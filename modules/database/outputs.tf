output "url" {
  description = "Database url"
  value       = "postgresql+psycopg2://${module.db.db_instance_endpoint}/${module.db.db_instance_name}"
}

output "host" {
  description = "Database host"
  value       = module.db.db_instance_address
}

output "port" {
  description = "Database host"
  value       = module.db.db_instance_port
}

output "database" {
  description = "Database host"
  value       = module.db.db_instance_name
}

output "username" {
  description = "Database username"
  value       = module.db.db_instance_username
  sensitive   = true
}

output "password" {
  description = "Database password"
  value       = local.password
  sensitive   = true
}
