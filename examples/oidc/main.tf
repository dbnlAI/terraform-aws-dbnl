provider "aws" {
  region = "us-east-1"
}

provider "kubernetes" {
  host                   = module.dbnl.cluster_endpoint
  cluster_ca_certificate = base64decode(module.dbnl.cluster_ca_cert)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", module.dbnl.cluster_name]
    command     = "aws"
  }
}

provider "helm" {
  kubernetes {
    host                   = module.dbnl.cluster_endpoint
    cluster_ca_certificate = base64decode(module.dbnl.cluster_ca_cert)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", module.dbnl.cluster_name]
      command     = "aws"
    }
  }
}

# Generate a random dev key.
resource "tls_private_key" "dev" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create dbnl module.
module "dbnl" {
  source = "../../"

  oidc_audience         = var.oidc_audience
  oidc_client_id        = var.oidc_client_id
  oidc_issuer           = var.oidc_issuer
  oidc_scopes           = var.oidc_scopes
  dev_token_private_key = tls_private_key.dev.private_key_pem
  domain                = var.domain
  instance_size         = "small"
  public_facing         = true
  registry_username     = var.registry_username
  registry_password     = var.registry_password
}
