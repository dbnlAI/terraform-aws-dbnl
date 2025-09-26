<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_clickhouse_iam_policy"></a> [clickhouse\_iam\_policy](#module\_clickhouse\_iam\_policy) | terraform-aws-modules/iam/aws//modules/iam-policy | ~> 5.0 |
| <a name="module_clickhouse_iam_role"></a> [clickhouse\_iam\_role](#module\_clickhouse\_iam\_role) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | ~> 5.0 |

## Resources

| Name | Type |
|------|------|
| [helm_release.clickhouse](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [random_password.clickhouse](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_oidc_provider_arn"></a> [cluster\_oidc\_provider\_arn](#input\_cluster\_oidc\_provider\_arn) | Kubernetes cluster OIDC provider ARN. | `string` | n/a | yes |
| <a name="input_helm_chart_version"></a> [helm\_chart\_version](#input\_helm\_chart\_version) | Helm release version. | `string` | `"9.3.4"` | no |
| <a name="input_helm_release_name"></a> [helm\_release\_name](#input\_helm\_release\_name) | Helm release name. | `string` | `"clickhouse"` | no |
| <a name="input_helm_release_namespace"></a> [helm\_release\_namespace](#input\_helm\_release\_namespace) | Helm release namespace. | `string` | `"clickhouse"` | no |
| <a name="input_password"></a> [password](#input\_password) | Database admin password. | `string` | `null` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Name prefix to apply to named resources. | `string` | n/a | yes |
| <a name="input_replica_count"></a> [replica\_count](#input\_replica\_count) | Number of ClickHouse replicas. | `number` | `3` | no |
| <a name="input_resources_preset"></a> [resources\_preset](#input\_resources\_preset) | Resources preset for ClickHouse pods. | `string` | `"large"` | no |
| <a name="input_s3_bucket"></a> [s3\_bucket](#input\_s3\_bucket) | S3 bucket name. | `string` | n/a | yes |
| <a name="input_s3_region"></a> [s3\_region](#input\_s3\_region) | S3 region. | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | Database admin username. | `string` | `"dbnl"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_host"></a> [host](#output\_host) | ClickHouse host |
| <a name="output_password"></a> [password](#output\_password) | ClickHouse password |
| <a name="output_port"></a> [port](#output\_port) | ClickHouse port |
| <a name="output_replicated"></a> [replicated](#output\_replicated) | Whether ClickHouse tables are replicated |
| <a name="output_username"></a> [username](#output\_username) | ClickHouse username |
<!-- END_TF_DOCS -->