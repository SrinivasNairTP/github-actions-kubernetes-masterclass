module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "skillpulse-vpc"

  cidr = "10.0.0.0/16"

  azs = [
    "ap-south-1a",
    "ap-south-1b"
  ]

  private_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  public_subnets = [
    "10.0.101.0/24",
    "10.0.102.0/24"
  ]

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.30"
  cluster_endpoint_public_access = true
  subnet_ids = module.vpc.private_subnets
  vpc_id     = module.vpc.vpc_id

  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {
    workers = {
      desired_size = 2
      min_size     = 2
      max_size     = 4

      instance_types = ["t3.micro"]
    }
  }
}

resource "aws_ecr_repository" "backend" {
  name = "skillpulse-backend-v2"
}

resource "aws_ecr_repository" "frontend" {
  name = "skillpulse-frontend-v2"
}