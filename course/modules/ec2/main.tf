resource "random_shuffle" "subnets" {
  input = var.subnets
  result_count = 1
}

module "ec2-instance" {
  source = "terraform-aws-modules/ec2-instance/aws"
  version = "2.7.0"

  name = "cloudcasts-${var.infra_env}"

  ami = var.instance_ami
  instance_type = var.instance_type
  vpc_security_group_ids = var.security_groups
  subnet_id = random_shuffle.subnets.result[0]

  root_block_device = [
    {
      volume_size = var.instance_root_device_size
      valume_type = "gp3"
    }
  ]

  tags = merge(
    {
      Name        = "cloudcasts-${var.infra_env}"
      Role        = var.infra_role
      Project     = "cloudcasts.io"
      Environment = var.infra_env
      ManagedBy   = "terraform"
    },
    var.tags
  )

}

# resource "aws_instance" "cloudcasts_web" {
#   ami = var.instance_ami
#   instance_type = var.instance_type

#   root_block_device {
#     volume_size = var.instance_root_device_size
#     volume_type = "gp3"
#   }

#   subnet_id = random_shuffle.subnets.result[0]
#   vpc_security_group_ids = var.security_groups

#   tags = {
#     Name        = "cloudcasts-${var.infra_env}-web"
#     Role        = var.infra_role
#     Project     = "cloudcasts.io"
#     Environment = var.infra_env
#     ManagedBy   = "terraform"
#   }
# }

resource "aws_eip" "cloudcasts_addr" {
  count = (var.create_eip) ? 1 : 0

  vpc = true

  lifecycle {
    prevent_destroy = false
  }

  tags = merge({
      Name        = "cloudcasts-${var.infra_env}-web-address"
      Role        = var.infra_role
      Project     = "cloudcasts.io"
      Environment = var.infra_env
      ManagedBy   = "terraform"
    },
    var.tags
  )
}

resource "aws_eip_association" "eip_assoc" {
  count = (var.create_eip) ? 1 : 0

  # instance_id = aws_instance.cloudcasts_web.id
  instance_id = module.ec2-instance.id[0]
  allocation_id = aws_eip.cloudcasts_addr[0].id
}
