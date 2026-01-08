module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "${var.project_name}-cluster"
  cluster_version = "1.29"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    private_nodes = {
      desired_size = 2
      min_size     = 2
      max_size     = 3

      instance_types = ["m6a.large"]
      capacity_type  = "ON_DEMAND"

      subnet_ids = module.vpc.private_subnets
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
