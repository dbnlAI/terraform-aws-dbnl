data "aws_availability_zones" "available" {
  count = var.create_vpc ? 1 : 0

  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

module "vpc" {
  count = var.create_vpc ? 1 : 0

  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.prefix}-vpc"

  cidr = var.vpc_cidr
  azs  = var.create_vpc ? data.aws_availability_zones.available[0].names : []

  public_subnets      = var.public_subnet_cidrs
  private_subnets     = var.private_subnet_cidrs
  database_subnets    = var.database_subnet_cidrs
  elasticache_subnets = var.redis_subnet_cidrs

  create_database_subnet_group    = false
  create_elasticache_subnet_group = false

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }
}
