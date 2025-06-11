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
| <a name="module_db"></a> [db](#module\_db) | terraform-aws-modules/rds/aws | ~> 6.2 |
| <a name="module_db_security_group"></a> [db\_security\_group](#module\_db\_security\_group) | terraform-aws-modules/security-group/aws | ~> 5.0 |

## Resources

| Name | Type |
|------|------|
| [random_password.db](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | Database name. | `string` | `"dbnl"` | no |
| <a name="input_ingress_cidr_blocks"></a> [ingress\_cidr\_blocks](#input\_ingress\_cidr\_blocks) | Database ingress CIDR blocks. | `list(string)` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Database instance type. | `string` | n/a | yes |
| <a name="input_password"></a> [password](#input\_password) | Database admin password. | `string` | `null` | no |
| <a name="input_port"></a> [port](#input\_port) | Database port. | `number` | `5432` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Name prefix to apply to named resources. | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Database subnet ids. | `list(string)` | n/a | yes |
| <a name="input_terraform_deletion_protection"></a> [terraform\_deletion\_protection](#input\_terraform\_deletion\_protection) | Whether or not terraform can delete the database on destroy. | `bool` | `false` | no |
| <a name="input_username"></a> [username](#input\_username) | Database admin username. | `string` | `"dbnl"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Database VPC id. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database"></a> [database](#output\_database) | Database host |
| <a name="output_host"></a> [host](#output\_host) | Database host |
| <a name="output_password"></a> [password](#output\_password) | Database password |
| <a name="output_port"></a> [port](#output\_port) | Database host |
| <a name="output_url"></a> [url](#output\_url) | Database url |
| <a name="output_username"></a> [username](#output\_username) | Database username |
<!-- END_TF_DOCS -->