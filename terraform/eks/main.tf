############################### EKS ###########################################
module "eks" {
  source = "../modules/eks"

  cluster_name                    = var.cluster_name
  cluster_version                 = var.cluster_version
  cluster_enabled_log_types       = var.cluster_enabled_log_types
  cluster_security_groups         = var.cluster_security_groups
  cluster_subnet_ids              = concat(data.terraform_remote_state.vpc.outputs.subnet_ids_dev, data.terraform_remote_state.vpc.outputs.subnet_ids_qa)
  cluster_endpoint_private_access = var.cluster_endpoint_private_access
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access
  cluster_public_access_cidrs     = var.cluster_public_access_cidrs
  enable_irsa                     = var.enable_irsa
  openid_connect_audiences        = var.openid_connect_audiences
  custom_oidc_thumbprints         = var.custom_oidc_thumbprints
  create_iam_role                 = var.create_iam_role
  iam_role_arn                    = var.iam_role_arn
  nodes_iam_role_arn              = var.nodes_iam_role_arn
  node_group_name                 = var.node_group_name
  instance_types                  = var.instance_types
  ami_type                        = var.ami_type
  release_version                 = var.release_version
  desired_size                    = var.desired_size
  max_size                        = var.max_size
  min_size                        = var.min_size
  enable_remote_access            = var.enable_remote_access
  ec2_ssh_key                     = var.ec2_ssh_key
  cluster_tags                    = var.cluster_tags
  node_tags                       = var.node_tags
  tags                            = merge(
    var.tags,
    { "Environment" = var.environment }
  )
}
