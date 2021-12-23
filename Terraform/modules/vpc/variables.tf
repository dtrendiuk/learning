# Input variable definitions

variable "env" {
  description = "Environment"
  default     = "dev-pro-test"
}

variable "vpc_cidr" {
  description = "VPC CidrBlock"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Public Subnet Cidrs"
  default = [
    "10.0.11.0/24",
    "10.0.21.0/24"
  ]
}

variable "private_subnet_cidrs" {
  description = "Private Subnet Cidrs"
  default = [
    "10.0.12.0/24",
    "10.0.22.0/24"
  ]
}

variable "database_subnet_cidrs" {
  description = "Database Subnet Cidrs"
  default = [
    "10.0.13.0/24",
    "10.0.23.0/24"
  ]
}

variable "sg_cidr" {
  description = "Security Group Cidrs"
  default     = "0.0.0.0/0"
}
