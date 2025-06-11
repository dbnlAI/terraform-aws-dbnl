variable "create_vpc" {
  type        = bool
  description = "Whether to create a new VPC for the app. If false, no VPC will be created."
  default     = true
}

variable "database_subnet_cidrs" {
  type        = list(string)
  description = "Database subnet CIDRs."
  default     = ["10.10.20.0/24", "10.10.21.0/24"]
}

variable "prefix" {
  type        = string
  description = "Name prefix to apply to named resources."
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private subnet CIDRs."
  default     = ["10.10.0.0/24", "10.10.1.0/24"]
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public subnet CIDRs."
  default     = ["10.10.10.0/24", "10.10.11.0/24"]
}

variable "redis_subnet_cidrs" {
  type        = list(string)
  description = "Redis subnet CIDRs."
  default     = ["10.10.30.0/24", "10.10.31.0/24"]
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR."
  default     = "10.10.0.0/16"
}
