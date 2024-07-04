variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "cluster_enabled_log_types" {
  type = list(string)
}

variable "iam_role_arn" {
  type = string
}

variable "cluster_security_groups" {
  type = list(string)
}

variable "cluster_endpoint_private_access" {
  type = bool
}

variable "cluster_endpoint_public_access" {
  type = bool
}

variable "cluster_public_access_cidrs" {
  type = list(string)
}

variable "enable_irsa" {
  type = bool
}

variable "openid_connect_audiences" {
  type = list(string)
}

variable "custom_oidc_thumbprints" {
  type = list(string)
}

variable "create_iam_role" {
  type = bool
}

variable "nodes_iam_role_arn" {
  type = string
}

variable "node_group_name" {
  type = string
}

variable "instance_types" {
  type = list(string)
}

variable "ami_type" {
  type = string
}

variable "release_version" {
  type = string
}

variable "desired_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "enable_remote_access" {
  type = bool
}

variable "ec2_ssh_key" {
  type = string
}

variable "environment" {
  type = string
}

variable "cluster_tags" {
  type = map(string)
}

variable "node_tags" {
  type = map(string)
}

variable "tags" {
  type = map(string)
}
