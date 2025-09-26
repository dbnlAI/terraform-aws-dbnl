variable "prefix" {
  type        = string
  description = "Name prefix to apply to named resources."
}

variable "cluster_oidc_provider_arn" {
  type        = string
  description = "Kubernetes cluster OIDC provider ARN."
}

variable "helm_release_name" {
  type        = string
  description = "Helm release name."
  default     = "clickhouse"
}

variable "helm_release_namespace" {
  type        = string
  description = "Helm release namespace."
  default     = "clickhouse"
}

variable "helm_chart_version" {
  type        = string
  description = "Helm release version."
  default     = "9.3.4"
}

variable "s3_bucket" {
  type        = string
  description = "S3 bucket name."
}

variable "s3_region" {
  type        = string
  description = "S3 region."
}

variable "username" {
  type        = string
  description = "Database admin username."
  default     = "dbnl"
  sensitive   = true
}

variable "password" {
  type        = string
  description = "Database admin password."
  sensitive   = true
  default     = null
}

variable "replica_count" {
  type        = number
  description = "Number of ClickHouse replicas."
  default     = 3
}

variable "resources_preset" {
  type        = string
  description = "Resources preset for ClickHouse pods."
  default     = "large"
}