locals {
  oidc_enabled  = var.oidc_issuer != null && var.oidc_audience != null && var.oidc_client_id != null && var.oidc_scopes != null
  admin_enabled = nonsensitive(var.admin_password != null)

  flower_basic_auth_enabled = nonsensitive(var.flower_basic_auth_username != null && var.flower_basic_auth_password != null)

  lb_annotations = {
    "alb.ingress.kubernetes.io/certificate-arn"    = var.domain_acm_certificate_arn
    "alb.ingress.kubernetes.io/group.name"         = "${var.prefix}-load-balancer"
    "alb.ingress.kubernetes.io/healthcheck-path"   = "/healthz"
    "alb.ingress.kubernetes.io/listen-ports"       = "[{\"HTTPS\":443}, {\"HTTP\":80}]"
    "alb.ingress.kubernetes.io/load-balancer-name" = "${var.prefix}-load-balancer"
    "alb.ingress.kubernetes.io/scheme"             = var.public_facing ? "internet-facing" : "internal"
    "alb.ingress.kubernetes.io/ssl-redirect"       = "443"
    "alb.ingress.kubernetes.io/target-type"        = "ip"
  }
}

# Create image pull secrets to pull containers from registry.
resource "kubernetes_secret" "image_pull_secret" {
  metadata {
    name = "${var.prefix}-docker-cfg"
  }

  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "${var.registry_server}" = {
          "username" = var.registry_username
          "password" = var.registry_password
          "auth"     = base64encode("${var.registry_username}:${var.registry_password}")
        }
      }
    })
  }
}

locals {
  values = {
    imagePullSecrets = [
      {
        name = kubernetes_secret.image_pull_secret.metadata[0].name
      }
    ]
    api = {
      serviceAccount = {
        annotations = {
          "eks.amazonaws.com/role-arn" : var.service_account_roles_arns["api-srv"]
        }
      }
    }
    auth = {
      admin = {
        enabled = local.admin_enabled
      }
      devToken = {
        issuer   = "https://${var.domain}"
        audience = "https://${var.domain}"
      }
      oidc = {
        enabled  = local.oidc_enabled
        issuer   = var.oidc_issuer
        audience = var.oidc_audience
        clientId = var.oidc_client_id
        scopes   = var.oidc_scopes
      }
    }
    db = {
      host     = var.db_host
      port     = var.db_port
      database = var.db_database
    }
    redis = {
      host     = var.redis_host
      port     = var.redis_port
      database = var.redis_database
      tls = {
        enabled = true
      }
    }

    ingress = {
      enabled = true
      api = {
        className   = "alb"
        annotations = local.lb_annotations
        basePath    = "/api"
        host        = var.domain
      }
      ui = {
        className   = "alb"
        annotations = local.lb_annotations
        host        = var.domain
      }
    }
    migration = {
      serviceAccount = {
        annotations = {
          "eks.amazonaws.com/role-arn" : var.service_account_roles_arns["migration-job"]
        }
      }
    }
    ui = {
      serviceAccount = {
        annotations = {
          "eks.amazonaws.com/role-arn" : var.service_account_roles_arns["ui-srv"]
        }
      }
    }
    worker = {
      realtime = {
        enabled = true
      }
      serviceAccount = {
        annotations = {
          "eks.amazonaws.com/role-arn" : var.service_account_roles_arns["worker-srv"]
        }
      }
    }
    flower = var.flower_enabled ? {
      enabled = true
      serviceAccount = {
        annotations = {
          "eks.amazonaws.com/role-arn" : var.service_account_roles_arns["flower-srv"]
        }
      }
      port = 5555
      basicAuth = {
        enabled = local.flower_basic_auth_enabled
      }
      } : {
      enabled        = false
      serviceAccount = {}
      basicAuth = {
        enabled = false
      }
      port = 0
    }
    storage = {
      s3 = {
        enabled = true
        bucket  = var.s3_bucket
        region  = var.s3_region
      }
    }
  }
}

# Create Helm release.
resource "helm_release" "dbnl" {
  name       = var.helm_release_name
  repository = "oci://${var.registry_server}/dbnlai/charts"
  chart      = "dbnl"
  version    = var.helm_chart_version
  namespace  = var.helm_release_namespace

  repository_username = var.registry_username
  repository_password = var.registry_password

  values = [yamlencode(local.values)]

  dynamic "set_sensitive" {
    for_each = local.admin_enabled ? ["admin-enabled"] : []
    content {
      name  = "auth.admin.hashedPassword"
      value = bcrypt(var.admin_password)
    }
  }

  set_sensitive {
    name  = "auth.devToken.privateKey"
    value = var.dev_token_private_key
  }

  set_sensitive {
    name  = "redis.username"
    value = var.redis_username
  }

  set_sensitive {
    name  = "redis.password"
    value = var.redis_password
  }

  set_sensitive {
    name  = "db.username"
    value = var.db_username
  }

  set_sensitive {
    name  = "db.password"
    value = var.db_password
  }

  dynamic "set_sensitive" {
    for_each = local.flower_basic_auth_enabled ? ["flower-basic-auth-password"] : []
    content {
      name  = "flower.basicAuth.password"
      value = var.flower_basic_auth_password
    }
  }

  dynamic "set_sensitive" {
    for_each = local.flower_basic_auth_enabled ? ["flower-basic-auth-username"] : []
    content {
      name  = "flower.basicAuth.username"
      value = var.flower_basic_auth_username
    }
  }

  lifecycle {
    precondition {
      condition     = local.admin_enabled != local.oidc_enabled
      error_message = "One and only one of oidc or admin should be set."
    }
  }

  depends_on = [
    kubernetes_secret.image_pull_secret
  ]
}
