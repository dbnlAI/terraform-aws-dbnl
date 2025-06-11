output "cluster_ca_cert" {
  description = "Kubernetes cluster CA certificate"
  value       = module.kubernetes.cluster_ca_cert
}

output "cluster_endpoint" {
  description = "Kubernetes cluster endpoint"
  value       = module.kubernetes.cluster_endpoint
}

output "cluster_name" {
  description = "Kubernetes cluster name"
  value       = module.kubernetes.cluster_name
}
