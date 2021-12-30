data "aws_region" "current" {}

data "aws_iam_policy_document" "ec2_instance_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "template_file" "user_data_webserver" {
  template = file("user_data_webserver.sh.tpl")
  vars = {
    region = "${data.aws_region.current.name}"
  }
}

data "template_file" "user_data_phpmyadmin" {
  template = file("user_data_phpmyadmin.sh.tpl")
  vars = {
    region = "${data.aws_region.current.name}"
  }
}
