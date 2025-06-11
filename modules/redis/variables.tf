variable "ingress_cidr_blocks" {
  description = "Redis ingress CIDR block"
  type        = list(string)
}

variable "instance_type" {
  description = "Redis instance type"
  type        = string
}

variable "password" {
  description = "Redis password"
  type        = string
  sensitive   = true
  default     = null
}

variable "port" {
  description = "Redis port"
  type        = number
  default     = 6379
}

variable "prefix" {
  type        = string
  description = "Name prefix to apply to named resources."
}

variable "subnet_ids" {
  type        = list(string)
  description = "Redis subnet ids."
}

variable "vpc_id" {
  description = "Redis VPC id"
  type        = string
}
