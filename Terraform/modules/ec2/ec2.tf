# EC2 instances

resource "aws_instance" "dev_pro_webserver_1" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.ec2_instance_type
  subnet_id              = var.subnet_id_webserver_1
  vpc_security_group_ids = var.vpc_security_group_ids_webserver
  iam_instance_profile   = aws_iam_instance_profile.dev_pro_instance_profile.name
  key_name               = aws_key_pair.dev_pro_key.key_name
  user_data              = data.template_file.user_data_webserver.rendered

  tags = {
    Name = "${var.env}-webserver1"
  }
}

resource "aws_instance" "dev_pro_webserver_2" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.ec2_instance_type
  subnet_id              = var.subnet_id_webserver_2
  vpc_security_group_ids = var.vpc_security_group_ids_webserver
  iam_instance_profile   = aws_iam_instance_profile.dev_pro_instance_profile.name
  key_name               = aws_key_pair.dev_pro_key.key_name
  user_data              = data.template_file.user_data_webserver.rendered

  tags = {
    Name = "${var.env}-webserver2"
  }
}

resource "aws_instance" "dev_pro_phpmyadmin" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.ec2_instance_type
  subnet_id              = var.subnet_id_phpmyadmin
  vpc_security_group_ids = var.vpc_security_group_ids_phpmyadmin
  iam_instance_profile   = aws_iam_instance_profile.dev_pro_instance_profile.name
  key_name               = aws_key_pair.dev_pro_key.key_name
  user_data              = data.template_file.user_data_phpmyadmin.rendered

  tags = {
    Name = "${var.env}-phpmyadmin"
  }
}

# IAM role

resource "aws_iam_role" "dev_pro_role" {
  name               = "SSM-CloudWatch-Full-S3-ReadOnly"
  assume_role_policy = data.aws_iam_policy_document.ec2_instance_policy.json
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMFullAccess",
    "arn:aws:iam::aws:policy/CloudWatchFullAccess",
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  ]
}

resource "aws_iam_instance_profile" "dev_pro_instance_profile" {
  name = "${var.env}-instance_profile"
  role = aws_iam_role.dev_pro_role.name
}
