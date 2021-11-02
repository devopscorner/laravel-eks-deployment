# ==========================================================================
#  Resources: EKS / main.tf (Main Terraform)
# --------------------------------------------------------------------------
#  Description
# --------------------------------------------------------------------------
#    - AWS Provider
#    - Common Tags
# ==========================================================================

# --------------------------------------------------------------------------
#  Data Sources
# --------------------------------------------------------------------------
data "aws_vpc" "devopscorner_vpc" {
  id = "vpc-[YOUR_VPC_ID]"
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.devopscorner_vpc.id

  tags = {
    Name = "devopscorner_vpc_public_*"
  }
}

# --------------------------------------------------------------------------
#  IAM Roles
# --------------------------------------------------------------------------
resource "aws_iam_role" "eks_cluster" {
  name = "eks-role-devopscorner_staging-cluster"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks_cluster.name
}

resource "aws_iam_role" "eks_nodes" {
  name = "eks-role-devopscorner_poc-nodes"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_nodes.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_nodes.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_nodes.name
}

# --------------------------------------------------------------------------
#  EKS Cluster Config
# --------------------------------------------------------------------------
resource "aws_eks_cluster" "aws_eks" {
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  name                      = "devopscorner_poc"
  role_arn                  = aws_iam_role.eks_cluster.arn
  version                   = "1.19"

  vpc_config {
    subnet_ids = data.aws_subnet_ids.all.ids
  }

  tags = {
    Environment     = "DEV"
    Name            = "EKS-STAGING"
    Department      = "DEVOPS"
    DepartmentGroup = "DEV-DEVOPS"
    ResourceGroup   = "DEV-EKS-STAGING"
  }
}

### OIDC config
resource "aws_iam_openid_connect_provider" "cluster" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = []
  url             = aws_eks_cluster.aws_eks.identity.0.oidc.0.issuer
}

### EKS Cluster Cloudwatch Logs Retention Period
# resource "aws_cloudwatch_log_group" "devopscorner_poc" {
#   name              = "/aws/eks/${aws_eks_cluster.aws_eks.id}/cluster"
#   retention_in_days = 1

#   tags = {
#     Name            = "devopscorner_poc"
#     Environment     = "DEV"
#     Name            = "EKS-STAGING"
#     Department      = "DEVOPS"
#     DepartmentGroup = "DEV-DEVOPS"
#     ResourceGroup   = "DEV-CWL-STAGING"
#   }
# }

# --------------------------------------------------------------------------
#  EKS Node Config
# --------------------------------------------------------------------------
resource "aws_eks_node_group" "devops_poc" {
  cluster_name    = aws_eks_cluster.aws_eks.name
  node_group_name = "devopscorner-staging"
  node_role_arn   = aws_iam_role.eks_nodes.arn
  subnet_ids      = data.aws_subnet_ids.all.ids
  instance_types  = ["t2.medium"]
  disk_size       = 20
  version         = "1.19"

  labels = {
    "environment" = "development",
    "node"        = "devopscorner-staging"
  }

  remote_access {
    ec2_ssh_key = "devopskey-staging"
  }

  scaling_config {
    desired_size = 2
    max_size     = 10
    min_size     = 2
  }

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

  tags = {
    Environment     = "DEV"
    Name            = "EKS-STAGING"
    Department      = "DEVOPS"
    DepartmentGroup = "DEV-DEVOPS"
    ResourceGroup   = "DEV-EKS-STAGING"
  }

  # --------------------------------------------------------------------------
  #  Dependencies IAM Role
  # --------------------------------------------------------------------------
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}
