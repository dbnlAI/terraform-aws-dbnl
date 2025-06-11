locals {
  password          = coalesce(var.password, random_password.redis.result)
  subnet_group_name = "${var.prefix}-redis-subnet-group"
}

module "redis_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "${var.prefix}-redis-security-group"
  description = "Redis security group."
  vpc_id      = var.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = var.port
      to_port     = var.port
      protocol    = "tcp"
      description = "Redis access from within VPC"
      cidr_blocks = join(",", var.ingress_cidr_blocks)
    },
  ]
}

resource "random_password" "redis" {
  length  = 20
  special = false
}

resource "aws_elasticache_subnet_group" "redis" {
  name       = local.subnet_group_name
  subnet_ids = var.subnet_ids

  tags = {
    Name = local.subnet_group_name
  }
}

resource "aws_elasticache_replication_group" "redis" {
  depends_on = [aws_elasticache_subnet_group.redis]

  replication_group_id = "${var.prefix}-redis"

  description = "Redis cluster"

  engine               = "redis"
  parameter_group_name = "default.redis7"
  engine_version       = "7.1"

  port = var.port

  node_type          = var.instance_type
  num_cache_clusters = 1

  auth_token                 = local.password
  transit_encryption_enabled = true
  at_rest_encryption_enabled = true

  subnet_group_name = local.subnet_group_name

  security_group_ids = [module.redis_security_group.security_group_id]
}
