# VPC Module

locals {
  subnets_publics = [
    for key, value in var.subnets :
    value.is_public == true ? {
      subnet_name            = key
      subnet_is_public       = value.is_public
      subnet_tag_eip         = value.tag_eip
      subnet_tag_nat_gateway = value.tag_nat_gateway
    } : null
  ]
  filtered_subnets_publics = [for subnet in local.subnets_publics : subnet if subnet != null]

  subnets_privates = [
    for key, value in var.subnets :
    value.is_public != true ? {
      subnet_name            = key
      subnet_is_public       = value.is_public
      subnet_tag_eip         = value.tag_eip
      subnet_tag_nat_gateway = value.tag_nat_gateway
    } : null
  ]
  filtered_subnets_privates = [for subnet in local.subnets_privates : subnet if subnet != null]

}

# VPC
###########################################################################
resource "aws_vpc" "this" {
  cidr_block           = var.networks.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    { Name = var.networks.name },
    var.tags
  )
}

# Private Subnets
############################################################################
resource "aws_subnet" "this" {
  for_each = var.subnets

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = merge(
    { Name = each.key },
    var.tags
  )

  depends_on = [aws_vpc.this]
}

# Internet Gateway
###########################################################################
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    { Name = var.networks.igw_tag },
    var.tags
  )

  depends_on = [aws_vpc.this]
}

# NAT Gateway
###########################################################################
resource "aws_eip" "this" {
  count = length(local.filtered_subnets_publics)

  domain = "vpc"

  tags = merge(
    var.tags,
    local.filtered_subnets_publics[count.index].subnet_tag_eip
  )

  depends_on = [aws_internet_gateway.this]
}

resource "aws_nat_gateway" "this" {
  count = length(local.filtered_subnets_publics)

  subnet_id     = aws_subnet.this[local.filtered_subnets_publics[count.index].subnet_name].id
  allocation_id = aws_eip.this[count.index].id

  tags = merge(
    var.tags,
    local.filtered_subnets_publics[count.index].subnet_tag_nat_gateway
  )

  depends_on = [aws_internet_gateway.this]
}

# RouteTable Public
###########################################################################
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(
    var.tags,
    { Name = var.name_rt_public }
  )
}

resource "aws_route_table_association" "public" {
  count = length(local.filtered_subnets_publics)

  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.this[local.filtered_subnets_publics[count.index].subnet_name].id
}

# RouteTable Private
###########################################################################
resource "aws_route_table" "private" {
  count = length(local.filtered_subnets_privates)

  vpc_id = aws_vpc.this.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this[count.index].id
  }

  tags = merge(
    var.tags,
    { Name = "rt-lambda-${replace(lower(local.filtered_subnets_privates[count.index].subnet_name)," ", "-")}" }
  )
}

resource "aws_route_table_association" "private" {
  count = length(local.filtered_subnets_privates)

  route_table_id = aws_route_table.private[count.index].id
  subnet_id      = aws_subnet.this[local.filtered_subnets_privates[count.index].subnet_name].id
}
