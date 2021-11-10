# ==========================================================================
#  Resources: EKS / variables.tf (Subnet)
# --------------------------------------------------------------------------
#  Description
# --------------------------------------------------------------------------
#    - Input Variable for AWS Provider
# ==========================================================================

variable "core_tags" {
  type = map(string)
  default = {
    Environment     = "DEV"
    Name            = "EKS-STAGING"
    Department      = "DEVOPS"
    DepartmentGroup = "DEV-DEVOPS"
    ResourceGroup   = "DEV-EKS-STAGING"
  }
}