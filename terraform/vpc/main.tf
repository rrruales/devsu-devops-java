################# VPC INTERNET ##################
module "vpc_internet" {
  source = "../modules/vpc_internet"

  networks       = var.networks
  subnets        = var.subnets
  name_rt_public = var.name_rt_public
  tags = merge(
    var.tags,
    { "Environment" = var.environment }
  )
}
