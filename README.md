# terraform-aws-dbnl

Terraform module to deploy dbnl in AWS.
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_app"></a> [app](#module\_app) | ./modules/app | n/a |
| <a name="module_blobstore"></a> [blobstore](#module\_blobstore) | ./modules/blobstore | n/a |
| <a name="module_database"></a> [database](#module\_database) | ./modules/database | n/a |
| <a name="module_iam"></a> [iam](#module\_iam) | ./modules/iam | n/a |
| <a name="module_kubernetes"></a> [kubernetes](#module\_kubernetes) | ./modules/kubernetes | n/a |
| <a name="module_loadbalancer"></a> [loadbalancer](#module\_loadbalancer) | ./modules/loadbalancer | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./modules/network | n/a |
| <a name="module_redis"></a> [redis](#module\_redis) | ./modules/redis | n/a |

## Resources

| Name | Type |
|------|------|
| [random_pet.prefix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [time_sleep.sequence_loadbalancer](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [aws_acm_certificate.domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/acm_certificate) | data source |
| [aws_subnet.private_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | Admin password. | `string` | `null` | no |
| <a name="input_create_vpc"></a> [create\_vpc](#input\_create\_vpc) | Whether to create a new VPC for the app. If false, an existing VPC must be provided. | `bool` | `true` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | Database password. | `string` | `null` | no |
| <a name="input_dev_token_private_key"></a> [dev\_token\_private\_key](#input\_dev\_token\_private\_key) | Private key used to sign dev tokens. | `string` | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | App domain name. | `string` | n/a | yes |
| <a name="input_domain_acm_certificate_arn"></a> [domain\_acm\_certificate\_arn](#input\_domain\_acm\_certificate\_arn) | ARN of the ACM certificate associated with the app domain. If not provided, the domain will be used to find an existing ACM certificate. | `string` | `null` | no |
| <a name="input_flower_basic_auth_password"></a> [flower\_basic\_auth\_password](#input\_flower\_basic\_auth\_password) | Flower basic auth password for UI access. | `string` | `null` | no |
| <a name="input_flower_basic_auth_username"></a> [flower\_basic\_auth\_username](#input\_flower\_basic\_auth\_username) | Flower basic auth username for UI access. | `string` | `null` | no |
| <a name="input_flower_enabled"></a> [flower\_enabled](#input\_flower\_enabled) | Whether to enable Flower monitoring for Celery queues. | `bool` | `false` | no |
| <a name="input_helm_chart_version"></a> [helm\_chart\_version](#input\_helm\_chart\_version) | Helm chart version. | `string` | `"0.22.0"` | no |
| <a name="input_helm_release_name"></a> [helm\_release\_name](#input\_helm\_release\_name) | Helm release name. | `string` | `"dbnl"` | no |
| <a name="input_helm_release_namespace"></a> [helm\_release\_namespace](#input\_helm\_release\_namespace) | Helm release namespace. | `string` | `"default"` | no |
| <a name="input_instance_size"></a> [instance\_size](#input\_instance\_size) | App instance size. | `string` | n/a | yes |
| <a name="input_oidc_audience"></a> [oidc\_audience](#input\_oidc\_audience) | OIDC audience. | `string` | `null` | no |
| <a name="input_oidc_client_id"></a> [oidc\_client\_id](#input\_oidc\_client\_id) | OIDC client id. | `string` | `null` | no |
| <a name="input_oidc_issuer"></a> [oidc\_issuer](#input\_oidc\_issuer) | OIDC issuer. | `string` | `null` | no |
| <a name="input_oidc_scopes"></a> [oidc\_scopes](#input\_oidc\_scopes) | OIDC scopes. | `string` | `"openid profile email"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Name prefix to apply to resources. | `string` | `null` | no |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | List of subnet IDs for the private subnets. Required if `create_vpc` is false. | `list(string)` | `null` | no |
| <a name="input_public_facing"></a> [public\_facing](#input\_public\_facing) | value | `bool` | `false` | no |
| <a name="input_redis_password"></a> [redis\_password](#input\_redis\_password) | Redis password. | `string` | `null` | no |
| <a name="input_registry_password"></a> [registry\_password](#input\_registry\_password) | Artifact registry password. | `string` | n/a | yes |
| <a name="input_registry_server"></a> [registry\_server](#input\_registry\_server) | Artifact registry server. | `string` | `"us-docker.pkg.dev"` | no |
| <a name="input_registry_username"></a> [registry\_username](#input\_registry\_username) | Artifact registry username. | `string` | n/a | yes |
| <a name="input_terms_of_service_disabled"></a> [terms\_of\_service\_disabled](#input\_terms\_of\_service\_disabled) | Whether to disable the terms of service acceptance requirement. | `bool` | `false` | no |
| <a name="input_terraform_deletion_protection"></a> [terraform\_deletion\_protection](#input\_terraform\_deletion\_protection) | Whether or not terraform can delete resources such as database, blobstore (S3) data. | `bool` | `false` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID to use for the app. Required if `create_vpc` is false. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_ca_cert"></a> [cluster\_ca\_cert](#output\_cluster\_ca\_cert) | Kubernetes cluster CA certificate |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Kubernetes cluster endpoint |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Kubernetes cluster name |
<!-- END_TF_DOCS -->