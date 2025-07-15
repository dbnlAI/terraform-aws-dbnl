<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bucket"></a> [bucket](#module\_bucket) | terraform-aws-modules/s3-bucket/aws | < 5.0.0 |
| <a name="module_bucket_read_write_iam_policy"></a> [bucket\_read\_write\_iam\_policy](#module\_bucket\_read\_write\_iam\_policy) | terraform-aws-modules/iam/aws//modules/iam-policy | n/a |

## Resources

| Name | Type |
|------|------|
| [random_pet.s3_bucket](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Name prefix to apply to named resources. | `string` | n/a | yes |
| <a name="input_terraform_deletion_protection"></a> [terraform\_deletion\_protection](#input\_terraform\_deletion\_protection) | Whether or not terraform can delete blobstore (S3) data on destroy. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket"></a> [bucket](#output\_bucket) | S3 bucket |
| <a name="output_bucket_read_write_iam_policy_arn"></a> [bucket\_read\_write\_iam\_policy\_arn](#output\_bucket\_read\_write\_iam\_policy\_arn) | S3 bucket read write policy |
| <a name="output_region"></a> [region](#output\_region) | S3 region |
<!-- END_TF_DOCS -->