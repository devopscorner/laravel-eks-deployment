module "vpc" {
  ### Using Terraform Registry ###
  # source = "terraform-aws-modules/vpc/aws"

  ### Using Terraform Submodule GIT ###
  source = "../../modules//terraform-aws-vpc/"

  cidr                      = ["10.34.0.0/20","10.35.0.0/20"]
  azs                       = ["ap-southeast-1a","ap-southeast-1b","ap-southeast-1c"]
  private_subnets           = ["10.35.0.0/20","10.35.16.0/20","10.35.32.0/20"]
  public_subnets            = ["10.34.0.0/20","10.34.16.0/20","10.34.32.0/20"]
  enable_nat_gateway        = true
  single_nat_gateway        = true
  enable_dns_hostnames      = true
  enable_dns_support        = true
  map_public_ip_on_launch   = true
  enable_dhcp_options       = true
  dhcp_options_domain_name         = "internal.service"      ## (default: *.svc.cluster.local)
  dhcp_options_domain_name_servers = ["AmazonProvidedDNS"]

  tags = merge(
    var.dev_tags,
    { "kubernetes.io/cluster/${lookup(var.dev_tags, "Environment")}" = "shared" }
  )

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }
}
