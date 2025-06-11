<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 5.0 |

## Resources

| Name | Type |
|------|------|
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_vpc"></a> [create\_vpc](#input\_create\_vpc) | Whether to create a new VPC for the app. If false, no VPC will be created. | `bool` | `true` | no |
| <a name="input_database_subnet_cidrs"></a> [database\_subnet\_cidrs](#input\_database\_subnet\_cidrs) | Database subnet CIDRs. | `list(string)` | <pre>[<br/>  "10.10.20.0/24",<br/>  "10.10.21.0/24"<br/>]</pre> | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Name prefix to apply to named resources. | `string` | n/a | yes |
| <a name="input_private_subnet_cidrs"></a> [private\_subnet\_cidrs](#input\_private\_subnet\_cidrs) | Private subnet CIDRs. | `list(string)` | <pre>[<br/>  "10.10.0.0/24",<br/>  "10.10.1.0/24"<br/>]</pre> | no |
| <a name="input_public_subnet_cidrs"></a> [public\_subnet\_cidrs](#input\_public\_subnet\_cidrs) | Public subnet CIDRs. | `list(string)` | <pre>[<br/>  "10.10.10.0/24",<br/>  "10.10.11.0/24"<br/>]</pre> | no |
| <a name="input_redis_subnet_cidrs"></a> [redis\_subnet\_cidrs](#input\_redis\_subnet\_cidrs) | Redis subnet CIDRs. | `list(string)` | <pre>[<br/>  "10.10.30.0/24",<br/>  "10.10.31.0/24"<br/>]</pre> | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC CIDR. | `string` | `"10.10.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_subnets"></a> [database\_subnets](#output\_database\_subnets) | VPC database subnet ids. |
| <a name="output_database_subnets_cidr_blocks"></a> [database\_subnets\_cidr\_blocks](#output\_database\_subnets\_cidr\_blocks) | VPC database subnet CIDR blocks. |
| <a name="output_elasticache_subnets"></a> [elasticache\_subnets](#output\_elasticache\_subnets) | VPC elasticache subnet ids. |
| <a name="output_elasticache_subnets_cidr_blocks"></a> [elasticache\_subnets\_cidr\_blocks](#output\_elasticache\_subnets\_cidr\_blocks) | VPC elasticache subnet CIDR blocks. |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | VPC private subnet ids. |
| <a name="output_private_subnets_cidr_blocks"></a> [private\_subnets\_cidr\_blocks](#output\_private\_subnets\_cidr\_blocks) | VPC private subnet CIDR blocks. |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | VPC id. |
<!-- END_TF_DOCS -->