variable "admin_password" {
  type        = string
  description = "Admin password."
  default     = null
  sensitive   = true
}

variable "db_host" {
  type        = string
  description = "Database host."
}

variable "db_port" {
  type        = number
  description = "Database port."
}

variable "db_database" {
  type        = string
  description = "Database name."
}

variable "db_username" {
  type        = string
  description = "Database username."
  sensitive   = true
}

variable "db_password" {
  type        = string
  description = "Database password."
  sensitive   = true
}

variable "dev_token_private_key" {
  type        = string
  description = "Private key used to sign dev tokens."
  sensitive   = true
}

variable "domain" {
  type        = string
  description = "App domain."
}

variable "domain_acm_certificate_arn" {
  type        = string
  description = "ARN of ACM SSL certificate associated with domain."
}

variable "flower_enabled" {
  type        = bool
  description = "Whether to enable Flower monitoring for Celery queues."
  default     = false
}

variable "flower_basic_auth_password" {
  type        = string
  description = "Flower basic auth password for UI access."
  sensitive   = true
  default     = null
}

variable "flower_basic_auth_username" {
  type        = string
  description = "Flower basic auth username for UI access."
  sensitive   = true
  default     = null
}

variable "helm_chart_version" {
  type        = string
  description = "Helm chart version."
}

variable "helm_release_name" {
  type        = string
  description = "Helm release name."
  default     = "dbnl"
}

variable "helm_release_namespace" {
  type        = string
  description = "Helm release namespace."
  default     = "default"
}

variable "oidc_audience" {
  type        = string
  description = "OIDC audience."
  default     = null
}

variable "oidc_client_id" {
  type        = string
  description = "OIDC client id."
  default     = null
}

variable "oidc_issuer" {
  type        = string
  description = "OIDC issuer."
  default     = null
}

variable "oidc_scopes" {
  type        = string
  description = "OIDC scopes."
  default     = "openid profile email"
}

variable "public_facing" {
  type        = bool
  description = "If true, expose to app to public internet."
  default     = false
}

variable "prefix" {
  type        = string
  description = "Name prefix to apply to resources."
}

variable "redis_host" {
  type        = string
  description = "Redis host."
}

variable "redis_port" {
  type        = number
  description = "Redis port."
}

variable "redis_database" {
  type        = number
  description = "Redis database number."
}

variable "redis_username" {
  type        = string
  description = "Redis username."
  sensitive   = true
}

variable "redis_password" {
  type        = string
  description = "Redis password."
  sensitive   = true
}

variable "registry_username" {
  type        = string
  description = "Artifact registry username."
  sensitive   = true
  default     = null
}

variable "registry_password" {
  type        = string
  description = "Artifact registry password."
  sensitive   = true
  default     = null
}

variable "service_account_roles_arns" {
  type        = map(string)
  description = "Service account roles ARNs."
}

variable "registry_server" {
  type        = string
  description = "Artifact registry server."
  default     = "ghcr.io/dbnlai"
}

variable "s3_bucket" {
  type        = string
  description = "S3 bucket name."
}

variable "s3_region" {
  type        = string
  description = "S3 region."
}

variable "terms_of_service_disabled" {
  type        = bool
  description = "Whether to disable the terms of service acceptance requirement."
  default     = false
}
