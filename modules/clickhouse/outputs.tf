output "host" {
  description = "ClickHouse host"
  value       = "${helm_release_name}.${helm_release_namespace}.svc.cluster.local"
}

output "port" {
  description = "ClickHouse port"
  value       = 8123
}

output "username" {
  description = "ClickHouse username"
  value       = var.username
  sensitive   = true
}

output "password" {
  description = "ClickHouse password"
  value       = var.password
  sensitive   = true
}

output "replicated" {
  description = "Whether ClickHouse tables are replicated"
  value       = var.replica_count > 1 ? true : false
}