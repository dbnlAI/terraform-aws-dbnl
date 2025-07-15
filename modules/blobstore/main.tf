resource "random_pet" "s3_bucket" {}

module "bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "< 5.0.0"

  bucket = "${var.prefix}-data-${random_pet.s3_bucket.id}"

  object_ownership = "BucketOwnerEnforced"

  force_destroy = !var.terraform_deletion_protection
  versioning = {
    enabled = true
  }

  attach_deny_insecure_transport_policy = true
  attach_require_latest_tls_policy      = true
}

module "bucket_read_write_iam_policy" {
  source = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name        = "${var.prefix}-data-read-write"
  description = "Data read/write access policy."

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # Give read/write access to bucket.
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
        ]
        Resource = [
          "${module.bucket.s3_bucket_arn}/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
        ]
        Resource = [
          "${module.bucket.s3_bucket_arn}"
        ]
      }
    ]
  })
}