output "bucket" {
  description = "S3 bucket"
  value       = module.bucket.s3_bucket_id
}

output "region" {
  description = "S3 region"
  value       = module.bucket.s3_bucket_region
}

output "bucket_read_write_iam_policy_arn" {
  description = "S3 bucket read write policy"
  value       = module.bucket_read_write_iam_policy.arn
}