resource "aws_security_group" "dev_pro_sg_public" {
  name   = "Security Group for Public Subnets"
  vpc_id = aws_vpc.dev_pro_vpc.id

  dynamic "ingress" {
    for_each = ["80", "443", "22"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.sg_cidr]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.sg_cidr]
  }

  tags = {
    Name = "${var.env}-sg_public"
  }
}

resource "aws_security_group" "dev_pro_sg_private" {
  name   = "Security Group for Private Subnets"
  vpc_id = aws_vpc.dev_pro_vpc.id

  dynamic "ingress" {
    for_each = ["80", "22"]
    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      security_groups = [aws_security_group.dev_pro_sg_public.id]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.sg_cidr]
  }

  tags = {
    Name = "${var.env}-sg_private"
  }
}

resource "aws_security_group" "dev_pro_sg_database" {
  name   = "Security Group for Database Subnets"
  vpc_id = aws_vpc.dev_pro_vpc.id

  dynamic "ingress" {
    for_each = ["3306", "22"]
    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      security_groups = [aws_security_group.dev_pro_sg_private.id]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.sg_cidr]
  }

  tags = {
    Name = "${var.env}-sg_database"
  }
}
