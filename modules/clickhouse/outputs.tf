output "host" {
  description = "ClickHouse host"
  value       = local.host
}

output "port" {
  description = "ClickHouse port"
  value       = 8123
}

output "username" {
  description = "ClickHouse username"
  value       = local.username
  sensitive   = true
}

output "password" {
  description = "ClickHouse password"
  value       = local.password
  sensitive   = true
}

output "replicated" {
  description = "Whether ClickHouse tables are replicated"
  value       = var.replica_count > 1 ? true : false
}