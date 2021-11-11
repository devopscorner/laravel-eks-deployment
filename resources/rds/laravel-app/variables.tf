# ==========================================================================
#  Resources: RDS / variables.tf (Subnet)
# --------------------------------------------------------------------------
#  Description
# --------------------------------------------------------------------------
#    - Input Variable for AWS Provider
# ==========================================================================

variable "dev_tags" {
  type = map(string)
  default = {
    Environment     = "DEV"
    Name            = "RDS-POSTGRES-12.8-LARAVEL-DEV"
    Department      = "DEVOPS"
    DepartmentGroup = "DEV-DEVOPS"
    ResourceGroup   = "DEV-RDS-DEVOPSCORNER"
  }
}

variable "uat_tags" {
  type = map(string)
  default = {
    Environment     = "UAT"
    Name            = "RDS-POSTGRES-12.8-LARAVEL-UAT"
    Department      = "DEVOPS"
    DepartmentGroup = "UAT-DEVOPS"
    ResourceGroup   = "UAT-RDS-DEVOPSCORNER"
  }
}