# EC2 instances

resource "aws_instance" "dev_pro_instance" {
  count                  = var.instance_count
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.ec2_instance_type
  subnet_id              = var.subnet_id_instance
  vpc_security_group_ids = var.vpc_security_group_ids_instance
  iam_instance_profile   = var.iam_instance_profile
  key_name               = var.key_name
  user_data              = var.user_data

  tags = merge({
    "Name" = var.name
    "Type" = var.type
    "Env"  = var.env
  }, var.tags)
}
