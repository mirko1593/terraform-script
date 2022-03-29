module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "2.77.0"

  name = "cloudcasts-${var.infra_env}-vpc"
  cidr = var.vpc_cidr

  azs = var.azs

  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false

  private_subnets = var.private_subnets
  public_subnets = var.public_subnets

  tags = {
    Name = "cloudcasts-${var.infra_env}-vpc"
    Project = "cloudcasts.io"
    Environment = var.infra_env
    ManagedBy = "terraform"
  }
}

# resource "aws_vpc" "vpc" {
#   cidr_block = var.vpc_cidr

#   tags = {
#     Name        = "cloudcasts-${var.infra_env}-vpc"
#     Project     = "cloudcasts.io"
#     Environment = var.infra_env
#     ManagedBy   = "terraform"
#   }
# }

# resource "aws_subnet" "public" {
#   for_each = var.public_subnet_numbers

#   vpc_id = aws_vpc.vpc.id
#   availability_zone = each.key

#   cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 4, each.value)

#   tags = {
#     Name        = "cloudcasts-${var.infra_env}-public-subnet"
#     Project     = "cloudcasts.io"
#     Role        = "public"
#     Environment = var.infra_env
#     ManagedBy   = "terraform"
#     Subnet      = "${each.key}-${each.value}"
#   }
# }

# resource "aws_subnet" "private" {
#   for_each = var.private_subnet_numbers

#   vpc_id = aws_vpc.vpc.id
#   availability_zone = each.key

#   cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 4, each.value)

#   tags = {
#     Name        = "cloudcasts-${var.infra_env}-private-subnet"
#     Project     = "cloudcasts.io"
#     Role        = "private"
#     Environment = var.infra_env
#     ManagedBy   = "terraform"
#     Subnet      = "${each.key}-${each.value}"
#   }
# }
