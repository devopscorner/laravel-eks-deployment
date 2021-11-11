# ==========================================================================
#  Resources: EKS / eks-node-devopscorner-uat.tf (EKS Node Configuration)
# --------------------------------------------------------------------------
#  Description
# --------------------------------------------------------------------------
#    - EKS Node Group Name
#    - EKS Version
#    - SSH Key
#    - Node VPC Subnet
#    - Node Scaling
#    - Node Tagging
# ==========================================================================

#============================================
# NODE GROUP: devopscorner-uat
#============================================

## CUSTOMAPP
resource "aws_eks_node_group" "devopscorner_node_uat" {
  cluster_name    = aws_eks_cluster.aws_eks.name
  node_group_name = "devopscorner_group_uat"
  node_role_arn   = aws_iam_role.eks_nodes.arn

  ### Moved to module.vpc ###
  # subnet_ids      = data.aws_subnet_ids.all.ids
  subnet_ids = module.vpc.private_subnets

  instance_types  = ["t3.medium"]
  disk_size       = 100
  version         = "1.21"

  labels = {
    "environment" = "staging",
    "node"        = "devopscorner-uat"
    "department"  = "devops"
  }

  remote_access {
    ec2_ssh_key = "devopscorner-k8s-staging"
    # source_security_group_ids = [local.vpn_sgid]
  }

  scaling_config {
    desired_size = 2
    max_size     = 10
    min_size     = 2
  }

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

  tags = var.dev_tags

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}
