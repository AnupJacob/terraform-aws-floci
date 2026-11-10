module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  for_each     = toset(var.regions)
  cluster_name = "${var.eks_environment_short}-eks-${each.key}"

  cluster_version = "1.31"

  # NETWORK ISOLATION placeing cluster control interfaces in my vpc
  vpc_id     = aws_vpc.my_floci_vpc[each.key].id
  subnet_ids = [aws_subnet.my_floci_private_subnet[each.key].id]

  # SECURITY BEST PRACTICE: Enables cryptographic OpenID trust mappings (IRSA)
  enable_irsa                 = true
  create_cloudwatch_log_group = false

  cluster_enabled_log_types = []

  enable_cluster_creator_admin_permissions = false

  eks_managed_node_groups = {
    primary_workers = {
      instance_types = ["t3.small"]

      min_size     = 1
      max_size     = 3
      desired_size = 2

      #____ Sandbox issue fix temp start
      create_node_security_group    = false
      create_cluster_security_group = false

      # 2. Extends timeout parameters for local runtime engine has time to respond
      cluster_timeouts = {
        create = "60m"
        update = "60m"
        delete = "60m"
      }
      # __ Sandbox issue fix temp end

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
