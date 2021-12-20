variable "env" {
  default = "dev-pro-test"
}

variable "region" {
  default = "eu-west-1"
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

variable "alb_name" {
  default = "dev-pro-alb"
}

variable "tg_1_name" {
  default = "dev-pro-tg-webserver"
}

variable "tg_1_port" {
  default = "80"
}

variable "tg_1_protocol" {
  default = "HTTP"
}

variable "tg_2_name" {
  default = "dev-pro-tg-phpmyadmin"
}

variable "tg_2_port" {
  default = "80"
}

variable "tg_2_protocol" {
  default = "HTTP"
}

variable "aws_lb_listener_port" {
  default = "80"
}

variable "aws_lb_listener_protocol" {
  default = "HTTP"
}

variable "phpmyadmin_instance_count" {
  default = "1"
}

variable "ec2_instance_type" {
  default = "t2.micro"
}

variable "cloudflare_email" {
  default = "dmytro.trendiuk@dev.pro"
}

variable "domain" {
  default = "trendv2021.pp.ua"
}

variable "cloudflare_zone_id" {
  default = "34ecc35d44b40c021b5909560781d6a6"
}
