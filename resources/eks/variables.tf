# ==========================================================================
#  Resources: EKS / variables.tf (Subnet)
# --------------------------------------------------------------------------
#  Description
# --------------------------------------------------------------------------
#    - Input Variable for AWS Provider
# ==========================================================================

variable "dev_tags" {
  type = map(string)
  default = {
    Environment     = "DEV"
    Name            = "EKS-1.21-STAGING-DEV"
    Department      = "DEVOPS"
    DepartmentGroup = "DEV-DEVOPS"
    ResourceGroup   = "DEV-EKS-DEVOPSCORNER"
  }
}

variable "uat_tags" {
  type = map(string)
  default = {
    Environment     = "UAT"
    Name            = "EKS-1.21-STAGING-UAT"
    Department      = "DEVOPS"
    DepartmentGroup = "UAT-DEVOPS"
    ResourceGroup   = "UAT-EKS-DEVOPSCORNER"
  }
}