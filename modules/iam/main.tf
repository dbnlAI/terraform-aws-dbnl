locals {
  api_service_account_name       = "${var.helm_release_name}-api-srv"
  migration_service_account_name = "${var.helm_release_name}-migration-job"
  scheduler_service_account_name = "${var.helm_release_name}-scheduler-srv"
  ui_service_account_name        = "${var.helm_release_name}-ui-srv"
  worker_service_account_name    = "${var.helm_release_name}-worker-srv"
  flower_service_account_name    = "${var.helm_release_name}-flower-srv"

}

module "api_srv_iam_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"

  role_name = "${var.prefix}-${local.api_service_account_name}"

  role_policy_arns = {
    # Read/write access to data S3 bucket.
    policy = var.s3_bucket_read_write_iam_policy_arn
  }

  oidc_providers = {
    ex = {
      provider_arn = var.cluster_oidc_provider_arn
      namespace_service_accounts = [
        "${var.helm_release_namespace}:${local.api_service_account_name}",
      ]
    }
  }
}

module "migration_job_iam_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"

  role_name = "${var.prefix}-${local.migration_service_account_name}"

  role_policy_arns = {
    # Read/write access to data S3 bucket.
    policy = var.s3_bucket_read_write_iam_policy_arn
  }

  oidc_providers = {
    ex = {
      provider_arn = var.cluster_oidc_provider_arn
      namespace_service_accounts = [
        "${var.helm_release_namespace}:${local.migration_service_account_name}",
      ]
    }
  }
}

module "ui_srv_iam_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"

  role_name = "${var.prefix}-${local.ui_service_account_name}"

  oidc_providers = {
    ex = {
      provider_arn = var.cluster_oidc_provider_arn
      namespace_service_accounts = [
        "${var.helm_release_namespace}:${local.ui_service_account_name}",
      ]
    }
  }
}

module "worker_srv_iam_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"

  role_name = "${var.prefix}-${local.worker_service_account_name}"

  role_policy_arns = {
    # Read/write access to data S3 bucket.
    policy = var.s3_bucket_read_write_iam_policy_arn
  }

  oidc_providers = {
    ex = {
      provider_arn = var.cluster_oidc_provider_arn
      namespace_service_accounts = [
        "${var.helm_release_namespace}:${local.worker_service_account_name}",
      ]
    }
  }
}

module "scheduler_srv_iam_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"

  role_name = "${var.prefix}-${local.scheduler_service_account_name}"

  oidc_providers = {
    ex = {
      provider_arn = var.cluster_oidc_provider_arn
      namespace_service_accounts = [
        "${var.helm_release_namespace}:${local.scheduler_service_account_name}",
      ]
    }
  }
}

module "flower_srv_iam_role" {
  count   = var.flower_enabled ? 1 : 0
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"

  role_name = "${var.prefix}-${local.flower_service_account_name}"

  oidc_providers = {
    ex = {
      provider_arn = var.cluster_oidc_provider_arn
      namespace_service_accounts = [
        "${var.helm_release_namespace}:${local.flower_service_account_name}",
      ]
    }
  }
}