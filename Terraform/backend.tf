# create backend.tf
terraform {
  backend "s3" {
    bucket = "devpro-tfstate2"
    key    = "test/terraform.tfstate"
    region = "eu-west-1"
  }
}
