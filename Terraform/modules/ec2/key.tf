# EC2 public key

resource "aws_key_pair" "dev_pro_key" {
  key_name   = "devprotest"
  public_key = file("./modules/ec2/devprotest.pub")

  tags = {
    Name = "${var.env}-key"
  }
}
