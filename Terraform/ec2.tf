resource "aws_instance" "dev_pro_webserver_1" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.ec2_instance_type
  subnet_id              = aws_subnet.dev_pro_private_subnets[0].id
  vpc_security_group_ids = [aws_security_group.dev_pro_sg_private.id]
  iam_instance_profile   = aws_iam_instance_profile.dev_pro_instance_profile.name
  key_name               = aws_key_pair.dev_pro_key.key_name
  user_data              = file("user_data_webserver.sh")

  tags = {
    Name = "${var.env}-webserver1"
  }
}

resource "aws_instance" "dev_pro_webserver_2" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.ec2_instance_type
  subnet_id              = aws_subnet.dev_pro_private_subnets[1].id
  vpc_security_group_ids = [aws_security_group.dev_pro_sg_private.id]
  iam_instance_profile   = aws_iam_instance_profile.dev_pro_instance_profile.name
  key_name               = aws_key_pair.dev_pro_key.key_name
  user_data              = file("user_data_webserver.sh")

  tags = {
    Name = "${var.env}-webserver2"
  }
}

resource "aws_instance" "dev_pro_phpmyadmin" {
  count                  = var.phpmyadmin_instance_count
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.ec2_instance_type
  subnet_id              = aws_subnet.dev_pro_private_subnets[0].id
  vpc_security_group_ids = [aws_security_group.dev_pro_sg_private.id]
  iam_instance_profile   = aws_iam_instance_profile.dev_pro_instance_profile.name
  key_name               = aws_key_pair.dev_pro_key.key_name
  user_data              = file("user_data_phpmyadmin.sh")

  tags = {
    Name = "${var.env}-phpmyadmin"
  }
}

resource "aws_key_pair" "dev_pro_key" {
  key_name   = "devprotest"
  public_key = file("devprotest.pub")

  tags = {
    Name = "${var.env}-key"
  }
}

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
