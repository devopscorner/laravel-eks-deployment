# ==========================================================================
#  Resources: EKS / eks-cluster-devopscorner-staging.tf (Cluster Configuration)
# --------------------------------------------------------------------------
#  Description
# --------------------------------------------------------------------------
#    - EKS Cluster Name
#    - EKS Version
#    - Cluster VPC Subnet
#    - Cluster Tagging
# ==========================================================================

resource "aws_eks_cluster" "aws_eks" {
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  name                            = "devopscorner_staging"
  role_arn                        = aws_iam_role.eks_cluster.arn
  version                         = "1.21"

  vpc_config {
    subnet_ids = module.vpc.private_subnets
  }

  tags = merge(
    var.core_tags,
    {
      "k8s.io/cluster-autoscaler/${lookup(var.core_tags, "Environment")}" = "owned",
      "k8s.io/cluster-autoscaler/enabled"                                 = "TRUE"
    },
  )
}

### OIDC config
resource "aws_iam_openid_connect_provider" "cluster" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = []
  url             = aws_eks_cluster.aws_eks.identity.0.oidc.0.issuer
}

#### EKS Cluster Cloudwatch Logs Retention Period
# resource "aws_cloudwatch_log_group" "devopscorner_staging" {
#   name              = "/aws/eks/${aws_eks_cluster.aws_eks.id}/cluster"
#   retention_in_days = 7

#   tags = {
#     Name            = "devopscorner_staging"
#     Department      = "DEVOPS"
#     Environment     = "DEV"
#     DepartmentGroup = "DEV-DEVOPS"
#     ResourceGroup   = "DEV-CWL-STAGING"
#   }
# }
