output "database_subnets" {
  description = "VPC database subnet ids."
  value       = var.create_vpc ? module.vpc[0].database_subnets : null
}

output "database_subnets_cidr_blocks" {
  description = "VPC database subnet CIDR blocks."
  value       = var.create_vpc ? module.vpc[0].database_subnets_cidr_blocks : null
}

output "elasticache_subnets" {
  description = "VPC elasticache subnet ids."
  value       = var.create_vpc ? module.vpc[0].elasticache_subnets : null
}

output "elasticache_subnets_cidr_blocks" {
  description = "VPC elasticache subnet CIDR blocks."
  value       = var.create_vpc ? module.vpc[0].elasticache_subnets_cidr_blocks : null
}

output "private_subnets" {
  description = "VPC private subnet ids."
  value       = var.create_vpc ? module.vpc[0].private_subnets : null
}

output "private_subnets_cidr_blocks" {
  description = "VPC private subnet CIDR blocks."
  value       = var.create_vpc ? module.vpc[0].private_subnets_cidr_blocks : null
}

output "vpc_id" {
  description = "VPC id."
  value       = var.create_vpc ? module.vpc[0].vpc_id : null
}
