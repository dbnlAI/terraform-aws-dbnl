locals {
  host                 = "${var.helm_release_name}.${var.helm_release_namespace}.svc.cluster.local"
  username             = var.username
  password             = coalesce(var.password, random_password.clickhouse.result)
  service_account_name = var.helm_release_name
}

resource "random_password" "clickhouse" {
  length  = 20
  special = false
}

module "clickhouse_iam_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "~> 5.0"

  name        = "${var.prefix}-clickhouse-all"
  description = "Clickhouse data all access policy."

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # Give all access to clickhouse folder in bucket.
      {
        Effect   = "Allow"
        Action   = ["s3:*"]
        Resource = "arn:aws:s3:::${var.s3_bucket}/clickhouse/*"
      },
    ]
  })
}

module "clickhouse_iam_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"

  role_name = "${var.prefix}-${local.service_account_name}"

  role_policy_arns = {
    policy = module.clickhouse_iam_policy.arn
  }

  oidc_providers = {
    ex = {
      provider_arn               = "${var.cluster_oidc_provider_arn}"
      namespace_service_accounts = ["${var.helm_release_namespace}:${local.service_account_name}"]
    }
  }
}

resource "helm_release" "clickhouse" {
  name             = var.helm_release_name
  repository       = "oci://registry-1.docker.io/bitnamicharts"
  chart            = "clickhouse"
  version          = var.helm_chart_version
  namespace        = var.helm_release_namespace
  create_namespace = true

  set {
    name  = "clusterName"
    value = "dbnl"
  }

  set {
    name  = "shards"
    value = 1
  }

  set {
    name  = "replicaCount"
    value = var.replica_count
  }

  set {
    name  = "resourcesPreset"
    value = var.resources_preset
  }

  set_sensitive {
    name  = "auth.username"
    value = local.username
  }

  set_sensitive {
    name  = "auth.password"
    value = local.password
  }

  set {
    name  = "configdFiles.00-config\\.xml"
    value = templatefile("${path.module}/00-config.xml.tftpl", { region = var.s3_region, bucket = var.s3_bucket })
  }

  set {
    name  = "persistence.size"
    value = "15Gi"
  }

  set {
    name  = "global.defaultStorageClass"
    value = "gp2"
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.clickhouse_iam_role.iam_role_arn
  }
}
