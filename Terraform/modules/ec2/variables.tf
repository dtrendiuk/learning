# Input variable definitions

variable "env" {
  description = "Environment"
  default     = "dev-pro-test"
}

variable "ec2_instance_type" {
  description = "EC2 Instance Type"
  default     = "t2.micro"
}

variable "subnet_id_webserver_1" {
  description = "First Webserver Subnet ID"
  default     = ""
}

variable "subnet_id_webserver_2" {
  description = "Second Webserver Subnet ID"
  default     = ""
}

variable "subnet_id_phpmyadmin" {
  description = "PhpMyAdmin Subnet ID"
  default     = ""
}

variable "vpc_security_group_ids_webserver" {
  description = "Webserver Security Group ID"
  default     = null
}

variable "vpc_security_group_ids_phpmyadmin" {
  description = "PhpMyAdmin security group ID"
  default     = null
}
