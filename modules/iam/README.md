<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_api_srv_iam_role"></a> [api\_srv\_iam\_role](#module\_api\_srv\_iam\_role) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | ~> 5.0 |
| <a name="module_flower_srv_iam_role"></a> [flower\_srv\_iam\_role](#module\_flower\_srv\_iam\_role) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | ~> 5.0 |
| <a name="module_migration_job_iam_role"></a> [migration\_job\_iam\_role](#module\_migration\_job\_iam\_role) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | ~> 5.0 |
| <a name="module_scheduler_srv_iam_role"></a> [scheduler\_srv\_iam\_role](#module\_scheduler\_srv\_iam\_role) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | ~> 5.0 |
| <a name="module_ui_srv_iam_role"></a> [ui\_srv\_iam\_role](#module\_ui\_srv\_iam\_role) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | ~> 5.0 |
| <a name="module_worker_srv_iam_role"></a> [worker\_srv\_iam\_role](#module\_worker\_srv\_iam\_role) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | ~> 5.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_oidc_provider_arn"></a> [cluster\_oidc\_provider\_arn](#input\_cluster\_oidc\_provider\_arn) | Kubernetes cluster OIDC provider ARN | `string` | n/a | yes |
| <a name="input_flower_enabled"></a> [flower\_enabled](#input\_flower\_enabled) | Enable Flower monitoring of Celery queues | `bool` | n/a | yes |
| <a name="input_helm_release_name"></a> [helm\_release\_name](#input\_helm\_release\_name) | Helm release name. | `string` | n/a | yes |
| <a name="input_helm_release_namespace"></a> [helm\_release\_namespace](#input\_helm\_release\_namespace) | Helm release namespace. | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Name prefix to apply to resources. | `string` | n/a | yes |
| <a name="input_s3_bucket_read_write_iam_policy_arn"></a> [s3\_bucket\_read\_write\_iam\_policy\_arn](#input\_s3\_bucket\_read\_write\_iam\_policy\_arn) | S3 bucket read/write policy ARN. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service_account_roles_arns"></a> [service\_account\_roles\_arns](#output\_service\_account\_roles\_arns) | Service account role ARNs |
<!-- END_TF_DOCS -->