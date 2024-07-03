variable "networks" {
  type = object({
    cidr_block = string
    name       = string
    igw_tag    = string
  })
}

variable "subnets" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
    is_public         = bool
    tag_eip           = optional(map(string), {})
    tag_nat_gateway   = optional(map(string), {})
  }))
}

variable "name_rt_public" {
  type = string
}

variable "tags" {
  type = map(string)
}
