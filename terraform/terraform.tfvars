####################### VPC #####################
networks = {
  cidr_block = "10.0.0.0/24"
  name       = "vpc-devsu"
  igw_tag    = "IG-devsu"
}

subnets = {
  "Private A" = {
    cidr_block        = "10.0.0.0/26"
    availability_zone = "us-east-1a"
    is_public         = false
  }
  "Public A" = {
    cidr_block        = "10.0.0.64/26"
    availability_zone = "us-east-1a"
    is_public         = true
    tag_eip           = { Name = "IP A Devsu" }
    tag_nat_gateway   = { Name = "NAT A Devsu" }
  }
  "Private B" = {
    cidr_block        = "10.0.0.128/26"
    availability_zone = "us-east-1b"
    is_public         = false
  }
  "Public B" = {
    cidr_block        = "10.0.0.192/24"
    availability_zone = "us-east-1b"
    is_public         = true
    tag_eip           = { Name = "IP B Devsu" }
    tag_nat_gateway   = { Name = "NAT B Devsu" }
  }
}

name_rt_public = "rt-public-devsu"
