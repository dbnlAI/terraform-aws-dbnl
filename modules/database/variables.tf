variable "instance_type" {
  type        = string
  description = "Database instance type."
}

variable "db_name" {
  type        = string
  description = "Database name."
  default     = "dbnl"
}

variable "password" {
  type        = string
  description = "Database admin password."
  sensitive   = true
  default     = null
}

variable "port" {
  type        = number
  description = "Database port."
  default     = 5432
}

variable "username" {
  type        = string
  description = "Database admin username."
  default     = "dbnl"
  sensitive   = true
}

variable "subnet_ids" {
  type        = list(string)
  description = "Database subnet ids."
}

variable "ingress_cidr_blocks" {
  type        = list(string)
  description = "Database ingress CIDR blocks."
}

variable "prefix" {
  type        = string
  description = "Name prefix to apply to named resources."
}

variable "terraform_deletion_protection" {
  type        = bool
  description = "Whether or not terraform can delete the database on destroy."
  default     = false
}

variable "vpc_id" {
  type        = string
  description = "Database VPC id."
}
