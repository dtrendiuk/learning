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

data "template_file" "user_data_bastion" {
  template = file("./user_data_bastion.sh.tpl")
  vars = {
    ansible_private_key = "${tls_private_key.ansible.private_key_pem}"
  }
}
