variable "desired_size" {
  type        = number
  description = "EKS cluster desired size."
  default     = 2
}

variable "instance_type" {
  type        = string
  description = "EKS cluster instance type."
}

variable "prefix" {
  type        = string
  description = "Name prefix to apply to named resources."
}

variable "subnet_ids" {
  type        = list(string)
  description = "EKS cluster subnets."
}

variable "cluster_version" {
  type        = string
  description = "EKS cluster version."
  default     = "1.30"
}

variable "vpc_id" {
  type        = string
  description = "EKS cluster VPC id."
}