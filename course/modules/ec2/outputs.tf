output "app_instance" {
  # value = aws_instance.cloudcasts_web.id
  value = module.ec2-instance.id[0]
}

output "app_eip" {
  value = aws_eip.cloudcasts_addr.*.public_ip
}
