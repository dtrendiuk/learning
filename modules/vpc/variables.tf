variable "env" {
  default = "dev-pro-test"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  default = [
    "10.0.11.0/24",
    "10.0.21.0/24"
  ]
}

variable "private_subnet_cidrs" {
  default = [
    "10.0.12.0/24",
    "10.0.22.0/24"
  ]
}

variable "database_subnet_cidrs" {
  default = [
    "10.0.13.0/24",
    "10.0.23.0/24"
  ]
}

variable "sg_cidr" {
  default = "0.0.0.0/0"
}

variable "sg_public" {
  default = [
    "80",
    "443"
  ]
}

variable "sg_private" {
  default = [
    "80",
    "22"
  ]
}

variable "sg_database" {
  default = [
    "3306",
    "22"
  ]
}
