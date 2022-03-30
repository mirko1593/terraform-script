terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.default_region
}

data "aws_ami" "cloudcasts_web" {
  most_recent = true

  filter {
    name   = "name"
    values = ["cloudcasts-${var.infra_env}-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["self"]
}


variable infra_env {
  type = string
  description = "infrastructure environment"
  default = "production"
}

variable default_region {
  type = string
  description = "the region this infrastruct is in"
  default = "cn-northwest-1"
}

module "ec2_app" {
  source = "../modules/ec2"

  infra_env = var.infra_env
  infra_role = "web"
  instance_type = "t3.small"
  instance_ami = data.aws_ami.cloudcasts_web.id

  # subnets = keys(module.vpc.vpc_public_subnets)
  subnets = module.vpc.vpc_public_subnets
  security_groups = [module.vpc.security_group_public]
  tags = { 
    Name = "cloudcasts-${var.infra_env}-web"
  }
  create_eip = true 
}

module "ec2_worker" {
  source = "../modules/ec2"

  infra_env = var.infra_env
  infra_role = "worker"
  instance_type = "t3.xlarge"
  instance_ami = data.aws_ami.cloudcasts_web.id
  instance_root_device_size = 50

  # subnets = keys(module.vpc.vpc_private_subnets)
  subnets = module.vpc.vpc_private_subnets
  security_groups = [module.vpc.security_group_public]
  tags = { 
    Name = "cloudcasts-${var.infra_env}-worker"
  }
  create_eip = false
}

module "vpc" {
  source = "../modules/vpc"

  infra_env = var.infra_env
  vpc_cidr = "10.0.0.0/17"

  azs = ["cn-northwest-1a", "cn-northwest-1b"]
  public_subnets = slice(cidrsubnets("10.0.0.0/17", 4, 4, 4, 4), 0, 2)
  private_subnets = slice(cidrsubnets("10.0.0.0/17", 4, 4, 4, 4), 2, 4)
}


