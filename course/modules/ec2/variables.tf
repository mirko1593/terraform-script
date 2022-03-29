variable infra_env {
  type = string
  description = "infrastructure environment"
}

variable infra_role {
  type = string
  description = "infrastructure purpose"
}

variable instance_ami {
  type = string 
  description = "server image to use"
}

variable instance_type {
  type = string
  description = "ec2 web server size"
  default = "t3.small"
}

variable instance_root_device_size {
  type = number
  description = "Root block device size in GB"
  default = 12
}

variable subnets {
  type = list(string)
  description = "valid subnets to assign to server"
}

variable security_groups {
  type = list(string)
  description = "secutity groups to assign to server"
  default = []
}

variable "tags" {
  type = map(string)
  default = {}
  description = "tags for the ec2 instance"
}

variable "create_eip" {
  type = bool
  default = false
  description = "whether or create an EIP for the ec2 instance or not"
}
