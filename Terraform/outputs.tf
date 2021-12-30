# Output variable definitions
output "alb_dns_name" {
  description = "ALB DNS"
  value       = aws_alb.dev_pro_alb.dns_name
}

output "sg_puplic_id" {
  description = "Public Security Group"
  value       = module.vpc.sg_public_id
}

output "sg_private_id" {
  description = "Private Security Group"
  value       = module.vpc.sg_private_id
}

output "sg_database_id" {
  description = "Database Security Group"
  value       = module.vpc.sg_database_id
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public Subnet IDs"
  value       = module.vpc.public_subnet_ids[*]
}

output "private_subnet_ids" {
  description = "Private Subnet IDs"
  value       = module.vpc.private_subnet_ids[*]
}

output "database_subnet_ids" {
  description = "Database Subnet IDs"
  value       = module.vpc.database_subnet_ids[*]
}

output "nat_gateway_ip" {
  description = "List of Elastic IPs created for AWS NAT Gateway"
  value       = module.vpc.nat_gateway_ip
}

output "user_data" {
  description = "Use variable in user_data script"
  value       = data.template_file.user_data_webserver.vars
}

output "user_data_rendered_webserver" {
  description = "Check variable in user_data script"
  value       = data.template_file.user_data_webserver.rendered
}

output "user_data_rendered_phpmyamin" {
  description = "Check variable in user_data script"
  value       = data.template_file.user_data_phpmyadmin.rendered
}

output "webserver_1_private_ip" {
  description = "First Webserver Private IP"
  value       = module.ec2-webserver1.private_ip
}

output "webserver_2_private_ip" {
  description = "Second Webserver Private IP"
  value       = module.ec2-webserver2.private_ip
}

output "phpmyadmin_private_ip" {
  description = "phpMyAdmin server Private IP"
  value       = module.ec2-phpmyadmin.private_ip

}
