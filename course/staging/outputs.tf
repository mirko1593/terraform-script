output "app_instance_id" {
  description = "hello world"
  value = module.ec2_app.app_instance
}

output "app_eip" {
  description = "hello world"
  value = module.ec2_app.app_eip
}

output "worker_instance_id" {
  description = "EC2 id of worker"
  value = module.ec2_worker.app_instance
}

output "worker_eip" {
  description = "eip of worker" # worker has no eip
  value = module.ec2_worker.app_eip
}
