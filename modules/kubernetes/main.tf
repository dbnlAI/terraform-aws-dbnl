module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.15"

  cluster_name    = "${var.prefix}-eks-cluster"
  cluster_version = var.cluster_version

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
  }

  eks_managed_node_groups = {
    main = {
      name = "${var.prefix}-ng-main"

      instance_types = [var.instance_type]

      desired_size = var.desired_size
      min_size     = var.desired_size
      max_size     = 4
    }
  }
}