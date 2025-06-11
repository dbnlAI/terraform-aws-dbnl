output "cluster_ca_cert" {
  description = "Kubernetes cluster CA certificate"
  value       = module.eks.cluster_certificate_authority_data
}

output "cluster_endpoint" {
  description = "Kubernetes cluster endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_name" {
  description = "Kubernetes cluster name"
  value       = module.eks.cluster_name
}

output "cluster_oidc_provider_arn" {
  description = "Kubernetes cluster OIDC provider ARN"
  value       = module.eks.oidc_provider_arn
}