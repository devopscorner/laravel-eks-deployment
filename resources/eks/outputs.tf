# ==========================================================================
#  Resources: EKS / output.tf (Output Terraform)
# --------------------------------------------------------------------------
#  Description
# --------------------------------------------------------------------------
#    - Return value terraform module
# ==========================================================================

# --------------------------------------------------------------------------
#  EKS Cluster Endpoint
# --------------------------------------------------------------------------
output "eks_cluster_endpoint" {
  value = aws_eks_cluster.aws_eks.endpoint
}

# --------------------------------------------------------------------------
#  EKS Cluster Certificate Authority
# --------------------------------------------------------------------------
output "eks_cluster_certificat_authority" {
  value = aws_eks_cluster.aws_eks.certificate_authority
}
