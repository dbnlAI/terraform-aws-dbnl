locals {
  password          = coalesce(var.password, random_password.db.result)
  subnet_group_name = "${var.prefix}-db-subnet-group"
}

module "db_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "${var.prefix}-db-security-group"
  description = "Database security group."
  vpc_id      = var.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = var.port
      to_port     = var.port
      protocol    = "tcp"
      description = "Database access from within VPC"
      cidr_blocks = join(",", var.ingress_cidr_blocks)
    },
  ]
}

resource "random_password" "db" {
  length  = 20
  special = false
}

module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 6.2"

  identifier = "${var.prefix}-db"

  engine               = "postgres"
  engine_version       = "14"
  family               = "postgres14"
  major_engine_version = "14"
  instance_class       = var.instance_type

  allocated_storage     = 20  # GiB
  max_allocated_storage = 100 # GiB

  storage_encrypted = true

  db_name                     = var.db_name
  port                        = var.port
  username                    = var.username
  password                    = local.password
  manage_master_user_password = false

  multi_az               = true
  subnet_ids             = var.subnet_ids
  create_db_subnet_group = true
  db_subnet_group_name   = local.subnet_group_name
  vpc_security_group_ids = [module.db_security_group.security_group_id]

  backup_window           = "03:00-06:00"
  backup_retention_period = 14 # days

  performance_insights_enabled          = true
  performance_insights_retention_period = 7 # days

  create_monitoring_role          = true
  monitoring_interval             = 60 # seconds
  monitoring_role_name            = "${var.prefix}-db-monitoring-role"
  monitoring_role_use_name_prefix = true
  deletion_protection             = var.terraform_deletion_protection

  parameters = [
    {
      name  = "autovacuum"
      value = 1
    },
    {
      name  = "client_encoding"
      value = "utf8"
    }
  ]
}
