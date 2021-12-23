output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.dev_pro_vpc.id
}

output "public_subnet_ids" {
  description = "Public Subnet IDs"
  value       = aws_subnet.dev_pro_public_subnets[*].id
}

output "private_subnet_ids" {
  description = "Private Subnet IDs"
  value       = aws_subnet.dev_pro_private_subnets[*].id
}

output "database_subnet_ids" {
  description = "Database Subnet IDs"
  value       = aws_subnet.dev_pro_database_subnets[*].id
}

output "nat_gateway_ip" {
  description = "List of Elastic IPs created for AWS NAT Gateway"
  value       = aws_eip.dev_pro_nat_gw_eip.public_ip
}

output "sg_public_id" {
  description = "Public Security Group ID"
  value       = aws_security_group.dev_pro_sg_public.id
}

output "sg_private_id" {
  description = "Private Security Group ID"
  value       = aws_security_group.dev_pro_sg_private.id
}

output "sg_database_id" {
  description = "Database Security Group ID"
  value       = aws_security_group.dev_pro_sg_database.id
}

output "latest_amazon_linux_ami_id" {
  description = "Latest Aamazon Linux 2 AMI ID"
  value       = data.aws_ami.latest_amazon_linux.id
}

output "latest_amazon_linux_ami_name" {
  description = "Latest Aamazon Linux 2 AMI Name"
  value       = data.aws_ami.latest_amazon_linux.name
}

output "alb_dns_name" {
  description = "ALB DNS"
  value       = aws_alb.dev_pro_alb.dns_name
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
