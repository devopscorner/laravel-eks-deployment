# ==========================================================================
#  Resources: EKS / main.tf (Main Terraform)
# --------------------------------------------------------------------------
#  Description
# --------------------------------------------------------------------------
#    - VPN Security Group
#    - EKS VPC References
#    - EKS VPC Subnet
# ==========================================================================

# --------------------------------------------------------------------------
#  VPN Staging for Remote Access
# --------------------------------------------------------------------------
# locals{
#   vpn_sgid = "sg-[YOUR_SECURITY_GROUP_ID]"
# }

# --------------------------------------------------------------------------
#  Data Sources
# --------------------------------------------------------------------------
data "aws_vpc" "devopscorner_vpc" {
  id = "vpc-[YOUR_VPC_ID]"
}

### Moved to module.vpc ###
# data "aws_subnet_ids" "all" {
#   vpc_id = data.aws_vpc.devopscorner_vpc.id

#   tags = {
#     Name = "devopscorner-staging-vpc_eks_private_*"
#   }
# }
