output "host" {
  description = "Redis host"
  value       = aws_elasticache_replication_group.redis.primary_endpoint_address
}

output "port" {
  description = "Redis port"
  value       = aws_elasticache_replication_group.redis.port
}

output "database" {
  description = "Redis database number"
  value       = 0
}

output "username" {
  description = "Redis username"
  value       = "default"
  sensitive   = true
}

output "password" {
  description = "Redis password"
  value       = local.password
  sensitive   = true
}
