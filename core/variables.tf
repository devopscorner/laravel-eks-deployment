# ==========================================================================
#  Core: variables.tf (Subnet)
# --------------------------------------------------------------------------
#  Description
# --------------------------------------------------------------------------
#    - Input Variable for AWS Provider
# ==========================================================================

# --------------------------------------------------------------------------
#  Variable K/V
# --------------------------------------------------------------------------
variable "region_primary" {
  description = "AWS Region to deploy to"
  default     = "ap-southeast-1"
}

# VPC Name
variable "vpc_name" {
  description = "VPC name given for deployment"
  default     = "devopscorner_vpc"
}

# Tag Variables
variable "environment" {
  description = "Target Environment"
  default     = "DEV"
}

variable "department" {
  description = "Department Owner"
  default     = "DEVOPS"
}
