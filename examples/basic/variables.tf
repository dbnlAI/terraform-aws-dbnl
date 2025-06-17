variable "admin_password" {
  description = "Admin password."
  type        = string
}

variable "domain" {
  description = "Domain to deploy to."
  type        = string
}

variable "registry_server" {
  type        = string
  description = "Artifact registry server."
  default     = "us-docker.pkg.dev"
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
