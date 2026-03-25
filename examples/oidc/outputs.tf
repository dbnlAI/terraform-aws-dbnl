output "cluster_name" {
  description = "EKS cluster name. Run: aws eks update-kubeconfig --region us-east-1 --name <cluster_name>"
  value       = module.dbnl.cluster_name
}

output "cluster_endpoint" {
  description = "EKS cluster API endpoint."
  value       = module.dbnl.cluster_endpoint
}