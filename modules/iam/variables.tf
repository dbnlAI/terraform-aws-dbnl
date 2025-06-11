variable "cluster_oidc_provider_arn" {
  type        = string
  description = "Kubernetes cluster OIDC provider ARN"
}

variable "flower_enabled" {
  type        = bool
  description = "Enable Flower monitoring of Celery queues"
}

variable "helm_release_name" {
  type        = string
  description = "Helm release name."
}

variable "helm_release_namespace" {
  type        = string
  description = "Helm release namespace."
}

variable "prefix" {
  type        = string
  description = "Name prefix to apply to resources."
}

variable "s3_bucket_read_write_iam_policy_arn" {
  type        = string
  description = "S3 bucket read/write policy ARN."
}