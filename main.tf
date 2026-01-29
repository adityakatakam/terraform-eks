module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = "my-cluster"
  kubernetes_version = "1.34"
  # create_kms_key = "false"

  # addons = {
  #   coredns                = {}
  #   eks-pod-identity-agent = {
  #     before_compute = true
  #   }
  #   kube-proxy             = {}
  #   vpc-cni                = {
  #     before_compute = true
  #   }
  # }

  # Optional
  endpoint_public_access = true

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  vpc_id                   = "vpc-0eac6a8f9b87c057b"
  subnet_ids               = ["subnet-0be832a654faa5685", "subnet-01cac77632b70c136"]
  control_plane_subnet_ids = ["subnet-0be832a654faa5685", "subnet-01cac77632b70c136"]

  # EKS Managed Node Group(s)
  eks_managed_node_groups = {
    example = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.xlarge"]

      min_size     = 1
      max_size     = 10
      desired_size = 2
    }
  }

  tags = {
    Terraform   = "true"
  }
}