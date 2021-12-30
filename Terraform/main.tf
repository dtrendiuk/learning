# expose modules

module "vpc" {
  source = ".//modules/vpc"
}

module "ec2-webserver1" {
  source = ".//modules/ec2"

  name                            = "${var.env}-webserver1"
  iam_instance_profile            = aws_iam_instance_profile.dev_pro_instance_profile.name
  key_name                        = aws_key_pair.dev_pro_key.key_name
  user_data                       = data.template_file.user_data_webserver.rendered
  vpc_security_group_ids_instance = [module.vpc.sg_private_id]
  subnet_id_instance              = module.vpc.private_subnet_ids[0]
}

module "ec2-webserver2" {
  source = ".//modules/ec2"

  name                            = "${var.env}-webserver2"
  iam_instance_profile            = aws_iam_instance_profile.dev_pro_instance_profile.name
  key_name                        = aws_key_pair.dev_pro_key.key_name
  vpc_security_group_ids_instance = [module.vpc.sg_private_id]
  subnet_id_instance              = module.vpc.private_subnet_ids[1]
  user_data                       = data.template_file.user_data_webserver.rendered
}

module "ec2-phpmyadmin" {
  source = ".//modules/ec2"

  name                            = "${var.env}-phpmyadmin"
  iam_instance_profile            = aws_iam_instance_profile.dev_pro_instance_profile.name
  key_name                        = aws_key_pair.dev_pro_key.key_name
  vpc_security_group_ids_instance = [module.vpc.sg_private_id]
  subnet_id_instance              = module.vpc.private_subnet_ids[0]
  user_data                       = data.template_file.user_data_phpmyadmin.rendered
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
