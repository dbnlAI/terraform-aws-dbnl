variable "admin_password" {
  type        = string
  description = "Admin password."
  default     = null
  sensitive   = true
}

variable "db_password" {
  type        = string
  description = "Database password."
  sensitive   = true
  default     = null
}

variable "dev_token_private_key" {
  type        = string
  description = "Private key used to sign dev tokens."
  sensitive   = true
}

variable "domain" {
  type        = string
  description = "App domain name."
}

variable "domain_acm_certificate_arn" {
  type        = string
  description = "ARN of the ACM certificate associated with the app domain. If not provided, the domain will be used to find an existing ACM certificate."
  default     = null
}

variable "create_vpc" {
  type        = bool
  description = "Whether to create a new VPC for the app. If false, an existing VPC must be provided."
  default     = true
}

variable "vpc_id" {
  type        = string
  description = "VPC ID to use for the app. Required if `create_vpc` is false."
  default     = null
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the private subnets. Required if `create_vpc` is false."
  default     = null
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
  default     = "0.25.0"
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

variable "instance_size" {
  type        = string
  description = "App instance size."

  validation {
    condition     = contains(["small", "medium"], var.instance_size)
    error_message = "instance_size should be one of [\"small\", \"medium\"]."
  }
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

variable "prefix" {
  type        = string
  description = "Name prefix to apply to resources."
  default     = null
}

variable "public_facing" {
  type        = bool
  description = "value"
  default     = false
}

variable "redis_password" {
  type        = string
  description = "Redis password."
  sensitive   = true
  default     = null
}

variable "registry_server" {
  type        = string
  description = "Artifact registry server."
  default     = "ghcr.io/dbnlai"
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

variable "terraform_deletion_protection" {
  type        = bool
  description = "Whether or not terraform can delete resources such as database, blobstore (S3) data."
  default     = false
}

variable "terms_of_service_disabled" {
  type        = bool
  description = "Whether to disable the terms of service acceptance requirement."
  default     = false
}
