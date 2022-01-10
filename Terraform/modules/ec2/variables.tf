# Input variable definitions

variable "instance_count" {
  default = "1"
}

variable "name" {
  description = "Name to be used on EC2 instance created"
  type        = string
  default     = ""
}

variable "type" {
  description = "Type to be used on EC2 instance created"
  type        = string
  default     = ""
}

variable "env" {
  description = "Env to be used on EC2 instance created"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "subnet_id_instance" {
  description = "Subnet ID"
  default     = ""
}

variable "key_name" {
  default = ""
}

variable "iam_instance_profile" {
  default = ""
}

variable "ec2_instance_type" {
  description = "EC2 Instance Type"
  default     = "t2.micro"
}

variable "public_subnet_id" {
  default = ""
}

variable "subnet_id_phpmyadmin" {
  description = "PhpMyAdmin Subnet ID"
  default     = ""
}

variable "vpc_security_group_ids_instance" {
  description = "Security Group ID"
  default     = ""
}

variable "user_data" {
  default = ""
}
