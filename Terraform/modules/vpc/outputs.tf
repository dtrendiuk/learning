# Output variable definitions

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
