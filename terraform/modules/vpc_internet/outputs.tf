# VPC
###########################################################################
output "vpc_id" {
  value       = aws_vpc.this.id
  description = "ID of VPC"
}

output "vpc_arn" {
  value       = aws_vpc.this.arn
  description = "ARN of VPC"
}

output "vpc_cidr_block" {
  value       = aws_vpc.this.cidr_block
  description = "CIDR Block of VPC"
}

# SUBNETS
###########################################################################
output "subnets_ids" {
  value = {
    for key, value in aws_subnet.this : key => value.id
  }
}

# INTERNET GATEWAY
###########################################################################
output "igw_id" {
  value = aws_internet_gateway.this.id
}

output "igw_arn" {
  value = aws_internet_gateway.this.arn
}

# NAT GATEWAY
###########################################################################
output "nat_ids" {
  value = aws_nat_gateway.this[*].id
}

output "nat_public_ips" {
  value = aws_nat_gateway.this[*].public_ip
}