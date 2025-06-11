<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.dbnl](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_secret.image_pull_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | Admin password. | `string` | `null` | no |
| <a name="input_db_database"></a> [db\_database](#input\_db\_database) | Database name. | `string` | n/a | yes |
| <a name="input_db_host"></a> [db\_host](#input\_db\_host) | Database host. | `string` | n/a | yes |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | Database password. | `string` | n/a | yes |
| <a name="input_db_port"></a> [db\_port](#input\_db\_port) | Database port. | `number` | n/a | yes |
| <a name="input_db_username"></a> [db\_username](#input\_db\_username) | Database username. | `string` | n/a | yes |
| <a name="input_dev_token_private_key"></a> [dev\_token\_private\_key](#input\_dev\_token\_private\_key) | Private key used to sign dev tokens. | `string` | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | App domain. | `string` | n/a | yes |
| <a name="input_domain_acm_certificate_arn"></a> [domain\_acm\_certificate\_arn](#input\_domain\_acm\_certificate\_arn) | ARN of ACM SSL certificate associated with domain. | `string` | n/a | yes |
| <a name="input_flower_basic_auth_password"></a> [flower\_basic\_auth\_password](#input\_flower\_basic\_auth\_password) | Flower basic auth password for UI access. | `string` | `null` | no |
| <a name="input_flower_basic_auth_username"></a> [flower\_basic\_auth\_username](#input\_flower\_basic\_auth\_username) | Flower basic auth username for UI access. | `string` | `null` | no |
| <a name="input_flower_enabled"></a> [flower\_enabled](#input\_flower\_enabled) | Whether to enable Flower monitoring for Celery queues. | `bool` | `false` | no |
| <a name="input_helm_chart_version"></a> [helm\_chart\_version](#input\_helm\_chart\_version) | Helm chart version. | `string` | n/a | yes |
| <a name="input_helm_release_name"></a> [helm\_release\_name](#input\_helm\_release\_name) | Helm release name. | `string` | `"dbnl"` | no |
| <a name="input_helm_release_namespace"></a> [helm\_release\_namespace](#input\_helm\_release\_namespace) | Helm release namespace. | `string` | `"default"` | no |
| <a name="input_oidc_audience"></a> [oidc\_audience](#input\_oidc\_audience) | OIDC audience. | `string` | `null` | no |
| <a name="input_oidc_client_id"></a> [oidc\_client\_id](#input\_oidc\_client\_id) | OIDC client id. | `string` | `null` | no |
| <a name="input_oidc_issuer"></a> [oidc\_issuer](#input\_oidc\_issuer) | OIDC issuer. | `string` | `null` | no |
| <a name="input_oidc_scopes"></a> [oidc\_scopes](#input\_oidc\_scopes) | OIDC scopes. | `string` | `"openid profile email"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Name prefix to apply to resources. | `string` | n/a | yes |
| <a name="input_public_facing"></a> [public\_facing](#input\_public\_facing) | If true, expose to app to public internet. | `bool` | `false` | no |
| <a name="input_redis_database"></a> [redis\_database](#input\_redis\_database) | Redis database number. | `number` | n/a | yes |
| <a name="input_redis_host"></a> [redis\_host](#input\_redis\_host) | Redis host. | `string` | n/a | yes |
| <a name="input_redis_password"></a> [redis\_password](#input\_redis\_password) | Redis password. | `string` | n/a | yes |
| <a name="input_redis_port"></a> [redis\_port](#input\_redis\_port) | Redis port. | `number` | n/a | yes |
| <a name="input_redis_username"></a> [redis\_username](#input\_redis\_username) | Redis username. | `string` | n/a | yes |
| <a name="input_registry_password"></a> [registry\_password](#input\_registry\_password) | Artifact registry password. | `string` | n/a | yes |
| <a name="input_registry_server"></a> [registry\_server](#input\_registry\_server) | Artifact registry server. | `string` | `"us-docker.pkg.dev"` | no |
| <a name="input_registry_username"></a> [registry\_username](#input\_registry\_username) | Artifact registry username. | `string` | n/a | yes |
| <a name="input_s3_bucket"></a> [s3\_bucket](#input\_s3\_bucket) | S3 bucket name. | `string` | n/a | yes |
| <a name="input_s3_region"></a> [s3\_region](#input\_s3\_region) | S3 region. | `string` | n/a | yes |
| <a name="input_service_account_roles_arns"></a> [service\_account\_roles\_arns](#input\_service\_account\_roles\_arns) | Service account roles ARNs. | `map(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->