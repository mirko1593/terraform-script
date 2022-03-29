variable "infra_env" {
  type = string
  description = "instrastruction environment"
}

variable "vpc_cidr" {
  type = string
  description = "The IP range to use for the VPC"
  default = "10.0.0./16"
}

variable "azs" {
  type = list(string)
  description = "AZs to create subnets into"
}

variable "public_subnets" {
  type = list(string)
  description = "subnets to create for public network traffic, one per AZ"
}

variable "private_subnets" {
  type = list(string)
  description = "subnets to create for private network traffic, one per AZ"
}

# variable "public_subnet_numbers" {
#   type = map(number)

#   description = "Map of AZ to a number that should be used for public subnets"

#   default = {
#     "cn-northwest-1a" = 1
#     "cn-northwest-1b" = 2
#   }
# }

# variable "private_subnet_numbers" {
#   type = map(number)

#   description = "Map of AZ to a number that should be used for private subnets"

#   default = {
#     "cn-northwest-1a" = 3
#     "cn-northwest-1b" = 4
#   }
# }
