variable "oidc_audience" {
  type        = string
  description = "OIDC audience."
}

variable "oidc_client_id" {
  type        = string
  description = "OIDC client id."
}

variable "oidc_issuer" {
  type        = string
  description = "OIDC issuer."
}

variable "oidc_scopes" {
  type        = string
  description = "OIDC scopes."
  default     = "openid profile email"
}

variable "domain" {
  description = "Domain to deploy to."
  type        = string
}

variable "registry_username" {
  type        = string
  description = "Artifact registry username."
  sensitive   = true
}

variable "registry_password" {
  type        = string
  description = "Artifact registry password."
  sensitive   = true
}
