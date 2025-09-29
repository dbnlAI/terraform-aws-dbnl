locals {
  cluster_name = "${var.prefix}-eks-cluster"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.31"

  cluster_name    = local.cluster_name
  cluster_version = var.cluster_version

  enable_cluster_creator_admin_permissions = true

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

module "ebs_iam_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"

  role_name = "${var.prefix}-ebs-csi-controller-service-account"

  role_policy_arns = {
    policy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  }

  oidc_providers = {
    ex = {
      provider_arn               = "${module.eks.oidc_provider_arn}"
      namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
    }
  }
}

resource "aws_eks_addon" "ebs" {
  cluster_name                = local.cluster_name
  addon_name                  = "aws-ebs-csi-driver"
  addon_version               = "v1.41.0-eksbuild.1"
  resolve_conflicts_on_update = "OVERWRITE"
  service_account_role_arn    = module.ebs_iam_role.iam_role_arn
}
