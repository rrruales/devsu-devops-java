############################### VPC ########################################
output "vpc_id" {
  value = module.vpc_internet.vpc_id
}

output "vpc_arn" {
  value = module.vpc_internet.vpc_arn
}

output "vpc_cidr_block" {
  value = module.vpc_internet.vpc_cidr_block
}

############################# SUBNETS ######################################
output "subnet_ids" {
  value = module.vpc_internet.subnets_ids
}

output "subnet_ids_dev" {
  value = [module.vpc_internet.subnets_ids["Private A"]]
}

output "subnet_ids_qa" {
  value = [module.vpc_internet.subnets_ids["Private B"]]
}
