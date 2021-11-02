# ==========================================================================
#  Core: natgw.tf (NAT Gate Way)
# --------------------------------------------------------------------------
#  Description
# --------------------------------------------------------------------------
#    - NAT Gateway from Private Subnet
#    - EIP Enabled
#    - Route Table for Private Subnet with NAT Gateway
# ==========================================================================

# --------------------------------------------------------------------------
#  NAT GW Tags
# --------------------------------------------------------------------------
locals {
  tags_private_rt = {
    ResourceGroup = "${var.environment}-RT"
    Name          = "devopscorner_vpc_private_rt"
  }

  tags_natgw = {
    ResourceGroup = "${var.environment}-NATGW"
    Name          = "devopscorner_vpc_private_natgw"
  }
}

# --------------------------------------------------------------------------
#  EIP (enabled)
# --------------------------------------------------------------------------
resource "aws_eip" "nat" { #1
  vpc = true
}

# --------------------------------------------------------------------------
#  NAT GW
# --------------------------------------------------------------------------
resource "aws_nat_gateway" "ngw" {       #2
  allocation_id = aws_eip.nat.id         #3
  subnet_id     = aws_subnet.public_a.id #4

  tags = merge(local.tags, local.tags_natgw)
}

# --------------------------------------------------------------------------
#  Route Table NAT GW
# --------------------------------------------------------------------------
resource "aws_route_table" "private" { #5
  vpc_id = aws_vpc.development.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id #6
  }

  tags = merge(local.tags, local.tags_private_rt)

}

# --------------------------------------------------------------------------
#  Route Table Private Subnet
# --------------------------------------------------------------------------
resource "aws_route_table_association" "private_1a" { #7
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_1b" { #7
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private.id
}
