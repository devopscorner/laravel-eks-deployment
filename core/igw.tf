# ==========================================================================
#  Core: igw.tf (Internet Gate Way)
# --------------------------------------------------------------------------
#  Description
# --------------------------------------------------------------------------
#    - IGW Public Subnet
#    - Route Table Public Subnet from IGW
# ==========================================================================

# --------------------------------------------------------------------------
#  IGW Tags
# --------------------------------------------------------------------------
locals {
  tags_public_rt = {
    ResourceGroup = "${var.environment}-RT"
    Name          = "devopscorner_vpc_public_rt"
  }

  tags_igw = {
    ResourceGroup = "${var.environment}-IGW"
    Name          = "devopscorner_vpc_public_igw"
  }
}

# --------------------------------------------------------------------------
#  IGW
# --------------------------------------------------------------------------
resource "aws_internet_gateway" "igw" { #1
  vpc_id = aws_vpc.development.id

  tags = merge(local.tags, local.tags_igw)
}

# --------------------------------------------------------------------------
#  Route Table for IGW
# --------------------------------------------------------------------------
resource "aws_route_table" "public" { #2
  vpc_id = aws_vpc.development.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(local.tags, local.tags_public_rt)
}

# --------------------------------------------------------------------------
#  Route Table with Public Subnet
# --------------------------------------------------------------------------
resource "aws_route_table_association" "public_1a" { #3
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_1b" { #3
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}
