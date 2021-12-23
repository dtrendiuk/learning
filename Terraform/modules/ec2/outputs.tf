# Output variable definitions

output "latest_amazon_linux_ami_id" {
  description = "Latest Aamazon Linux 2 AMI ID"
  value       = data.aws_ami.latest_amazon_linux.id
}

output "latest_amazon_linux_ami_name" {
  description = "Latest Aamazon Linux 2 AMI Name"
  value       = data.aws_ami.latest_amazon_linux.name
}

output "webserver_1_id" {
  description = "First Webserver ID"
  value       = aws_instance.dev_pro_webserver_1.id
}

output "webserver_2_id" {
  description = "Second Webserver ID"
  value       = aws_instance.dev_pro_webserver_2.id
}

output "phpmyadmin_id" {
  description = "phpMyAdmin server ID"
  value       = aws_instance.dev_pro_phpmyadmin.id
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
