# Output variable definitions

output "latest_amazon_linux_ami_id" {
  description = "Latest Aamazon Linux 2 AMI ID"
  value       = data.aws_ami.latest_amazon_linux.id
}

output "latest_amazon_linux_ami_name" {
  description = "Latest Aamazon Linux 2 AMI Name"
  value       = data.aws_ami.latest_amazon_linux.name
}

output "instance" {
  description = "The instance"
  value       = aws_instance.dev_pro_instance[*].id
}

output "public_ip" {
  description = "The public IP address assigned to the instance"
  value       = try(aws_instance.dev_pro_instance[0].public_ip)
}

output "private_ip" {
  description = "The private IP address assigned to the instance."
  value       = try(aws_instance.dev_pro_instance[0].private_ip)
}
