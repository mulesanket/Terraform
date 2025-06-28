output "public_ip" {
  value = module.ec2.public_ip
}

output "rds_endpoint" {
  value = module.rds.endpoint
}

output "rds_admin_user" {
  value = var.db_username
}
