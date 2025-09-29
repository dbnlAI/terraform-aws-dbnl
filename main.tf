locals {
  domain_acm_certificate_arn = var.domain_acm_certificate_arn == null ? data.aws_acm_certificate.domain[0].arn : var.domain_acm_certificate_arn
  prefix                     = coalesce(var.prefix, resource.random_pet.prefix.id)
  vpc_validation = (
    (var.create_vpc && var.vpc_id != null) ? error("vpc_id must be null if create_vpc is true")
    : (var.create_vpc == false && var.vpc_id == null) ? error("vpc_id must be provided if create_vpc is false")
    : true
  )
  vpc_id = var.create_vpc ? module.network.vpc_id : var.vpc_id
  subnet_ids_validation = (
    (var.create_vpc && var.private_subnet_ids != null) ? error("private_subnet_ids must be null if create_vpc is true")
    : (var.create_vpc == false && var.private_subnet_ids == null) ? error("private_subnet_ids must be provided if create_vpc is false")
    : true
  )
  private_subnet_ids    = var.create_vpc ? module.network.private_subnets : var.private_subnet_ids
  private_subnet_cidrs  = var.create_vpc ? module.network.private_subnets_cidr_blocks : data.aws_subnet.private_subnets[*].cidr_block
  database_subnet_ids   = var.create_vpc ? module.network.database_subnets : local.private_subnet_ids
  database_subnet_cidrs = var.create_vpc ? module.network.database_subnets_cidr_blocks : local.private_subnet_cidrs
  redis_subnet_ids      = var.create_vpc ? module.network.elasticache_subnets : var.private_subnet_ids
  redis_subnet_cidrs    = var.create_vpc ? module.network.elasticache_subnets_cidr_blocks : local.private_subnet_cidrs
}

data "aws_subnet" "private_subnets" {
  for_each = toset(var.private_subnet_ids == null ? [] : var.private_subnet_ids)
}

data "aws_acm_certificate" "domain" {
  count    = var.domain_acm_certificate_arn == null ? 1 : 0
  domain   = var.domain
  statuses = ["ISSUED"]
}

resource "random_pet" "prefix" {
  length = 1
}

module "network" {
  source = "./modules/network"

  create_vpc = var.create_vpc

  prefix = local.prefix
}

module "kubernetes" {
  source = "./modules/kubernetes"

  prefix = local.prefix

  vpc_id     = local.vpc_id
  subnet_ids = local.private_subnet_ids

  instance_type = local.instance_types[var.instance_size].kubernetes

  # NOTE: attempting to destroy the network module before the kubernetes module
  # may cause resource deletion errors, as services like the load balancer
  # controller will still be trying to access AWS endpoints,
  # but resources like the internet gateway will be destroyed.
  depends_on = [
    module.network
  ]
}

module "loadbalancer" {
  source = "./modules/loadbalancer"

  prefix = local.prefix

  cluster_name              = module.kubernetes.cluster_name
  cluster_oidc_provider_arn = module.kubernetes.cluster_oidc_provider_arn

  depends_on = [
    module.kubernetes
  ]
}

module "blobstore" {
  source = "./modules/blobstore"

  prefix = local.prefix

  terraform_deletion_protection = var.terraform_deletion_protection
}

module "database" {
  source = "./modules/database"

  prefix = local.prefix

  vpc_id              = local.vpc_id
  subnet_ids          = local.database_subnet_ids
  ingress_cidr_blocks = local.private_subnet_cidrs

  password = var.db_password

  instance_type = local.instance_types[var.instance_size].database

  terraform_deletion_protection = var.terraform_deletion_protection
}

module "redis" {
  source = "./modules/redis"

  prefix = local.prefix

  vpc_id              = local.vpc_id
  subnet_ids          = local.redis_subnet_ids
  ingress_cidr_blocks = local.private_subnet_cidrs

  password = var.redis_password

  instance_type = local.instance_types[var.instance_size].redis
}

module "iam" {
  source = "./modules/iam"

  cluster_oidc_provider_arn = module.kubernetes.cluster_oidc_provider_arn

  helm_release_name      = var.helm_release_name
  helm_release_namespace = var.helm_release_namespace

  prefix = local.prefix

  s3_bucket_read_write_iam_policy_arn = module.blobstore.bucket_read_write_iam_policy_arn

  flower_enabled = var.flower_enabled
}

# The allows the load balancer controller to clean up the load balancer
# after the helm release is deleted, before the LB controller itself is deleted.
resource "time_sleep" "sequence_loadbalancer" {
  destroy_duration = "90s"

  depends_on = [
    module.loadbalancer,
  ]
}

module "clickhouse" {
  count  = var.clickhouse_enabled ? 1 : 0
  source = "./modules/clickhouse"

  prefix = local.prefix

  cluster_oidc_provider_arn = module.kubernetes.cluster_oidc_provider_arn

  s3_bucket = module.blobstore.bucket
  s3_region = module.blobstore.region
}

module "app" {
  source = "./modules/app"

  admin_password = var.admin_password

  helm_chart_version     = var.helm_chart_version
  helm_release_name      = var.helm_release_name
  helm_release_namespace = var.helm_release_namespace

  clickhouse_enabled    = length(module.clickhouse) > 0
  clickhouse_host       = length(module.clickhouse) > 0 ? module.clickhouse[0].host : null
  clickhouse_port       = length(module.clickhouse) > 0 ? module.clickhouse[0].port : null
  clickhouse_username   = length(module.clickhouse) > 0 ? module.clickhouse[0].username : null
  clickhouse_password   = length(module.clickhouse) > 0 ? module.clickhouse[0].password : null
  clickhouse_replicated = length(module.clickhouse) > 0 ? module.clickhouse[0].replicated : null

  db_host     = module.database.host
  db_port     = module.database.port
  db_database = module.database.database
  db_username = module.database.username
  db_password = module.database.password

  dev_token_private_key = var.dev_token_private_key

  domain                     = var.domain
  domain_acm_certificate_arn = local.domain_acm_certificate_arn

  oidc_audience  = var.oidc_audience
  oidc_client_id = var.oidc_client_id
  oidc_issuer    = var.oidc_issuer
  oidc_scopes    = var.oidc_scopes

  prefix = local.prefix

  public_facing = var.public_facing

  terms_of_service_disabled = var.terms_of_service_disabled

  redis_host     = module.redis.host
  redis_port     = module.redis.port
  redis_database = module.redis.database
  redis_username = module.redis.username
  redis_password = module.redis.password

  registry_server   = var.registry_server
  registry_username = var.registry_username
  registry_password = var.registry_password

  service_account_roles_arns = module.iam.service_account_roles_arns

  s3_bucket = module.blobstore.bucket
  s3_region = module.blobstore.region

  flower_enabled             = var.flower_enabled
  flower_basic_auth_password = var.flower_basic_auth_password
  flower_basic_auth_username = var.flower_basic_auth_username

  depends_on = [
    module.clickhouse,
    module.kubernetes,
    time_sleep.sequence_loadbalancer,
  ]
}
