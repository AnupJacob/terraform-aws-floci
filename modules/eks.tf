module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  for_each     = toset(var.regions)
  cluster_name = "${substr(var.environments[0], 0, 3)}-eks-${each.key}"

  cluster_version = "1.31"

  # NETWORK ISOLATION placeing cluster control interfaces in my vpc
  vpc_id     = aws_vpc.my_floci_vpc[each.key].id
  subnet_ids = [aws_subnet.my_floci_private_subnet[each.key].id]

  # SECURITY BEST PRACTICE: Enables cryptographic OpenID trust mappings (IRSA)
  enable_irsa = true

  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {
    primary_workers = {
      instance_types = ["t3.small"]

      min_size     = 1
      max_size     = 3
      desired_size = 2

      # Change to ON_DEMAND for strict production guarantees
      capacity_type = "SPOT"

      # Forces worker nodes to spawn strictly inside private subnets away from the public edge
      subnet_ids = [aws_subnet.my_floci_private_subnet[each.key].id]

      tags = {
        Environment = var.environments[0]
      }
    }
  }

  tags = {
    Infrastructure = var.infrastructure
    Environment    = var.environments[0]
  }
}
