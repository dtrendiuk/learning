# Output variable definitions

output "latest_amazon_linux_ami_id" {
  description = "Latest Aamazon Linux 2 AMI ID"
  value       = module.ec2.latest_amazon_linux_ami_id
}

output "latest_amazon_linux_ami_name" {
  description = "Latest Aamazon Linux 2 AMI Name"
  value       = module.ec2.latest_amazon_linux_ami_name
}

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
