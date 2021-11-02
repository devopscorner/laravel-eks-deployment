# ==========================================================================
#  Core: subnet.tf (Subnet)
# --------------------------------------------------------------------------
#  Description
# --------------------------------------------------------------------------
#    - Public Subnet
#    - Private Subnet
# ==========================================================================

# --------------------------------------------------------------------------
#  Subnet Tags
# --------------------------------------------------------------------------
locals {
  tags_public_subnet = {
    ResourceGroup = "${var.environment}-PUB-SUBNET"
    Name          = "devopscorner_vpc"
  }

  tags_private_subnet = {
    ResourceGroup = "${var.environment}-PRIV-SUBNET"
  }
}

# --------------------------------------------------------------------------
#  Private Subnet
# --------------------------------------------------------------------------
resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.development.id
  cidr_block        = "172.200.0.0/20"
  availability_zone = "ap-southeast-1a"

  tags = merge(local.tags, local.tags_private_subnet, { Name = "${var.vpc_name}_private_1a" })
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.development.id
  cidr_block        = "172.200.32.0/20"
  availability_zone = "ap-southeast-1b"

  tags = merge(local.tags, local.tags_private_subnet, { Name = "${var.vpc_name}_private_1b" })
}

# --------------------------------------------------------------------------
#  Public Subnet
# --------------------------------------------------------------------------
resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.development.id
  cidr_block              = "172.200.16.0/20"
  availability_zone       = "ap-southeast-1a"
  map_public_ip_on_launch = true

  tags = merge(local.tags, local.tags_public_subnet, { Name = "${var.vpc_name}_public_1a" })

}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.development.id
  cidr_block              = "172.200.64.0/20"
  availability_zone       = "ap-southeast-1b"
  map_public_ip_on_launch = true

  tags = merge(local.tags, local.tags_public_subnet, { Name = "${var.vpc_name}_public_1b" })
}
