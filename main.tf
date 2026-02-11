resource "aws_eks_cluster" "main" {
  name     = var.env
  role_arn = aws_iam_role.cluster.arn
  version  = "1.34"
  vpc_config {
    subnet_ids = ["subnet-0be832a654faa5685", "subnet-01cac77632b70c136"]
  }
  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
  }
}

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "main"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = ["subnet-0be832a654faa5685", "subnet-01cac77632b70c136"]
  instance_types  = ["t3.xlarge"]

  scaling_config {
    desired_size = 1
    min_size     = 1
    max_size     = 10
  }

  update_config {
    max_unavailable = 1
  }
}

resource "aws_eks_access_entry" "workstation" {
  cluster_name      = aws_eks_cluster.main.name
  principal_arn     = "arn:aws:iam::667473681029:role/workstation-role"
  # kubernetes_groups = ["group-1", "group-2"]
  type              = "STANDARD"
}

resource "aws_eks_access_policy_association" "workstation" {
  cluster_name  = aws_eks_cluster.main.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = "arn:aws:iam::667473681029:role/workstation-role"

  access_scope {
    type       = "Cluster"
    # namespaces = ["example-namespace"]
  }
}