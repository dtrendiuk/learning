resource "aws_security_group" "dev_pro_sg_public" {
  name   = "Security Group for Public Subnets"
  vpc_id = aws_vpc.dev_pro_vpc.id

  dynamic "ingress" {
    for_each = ["80", "443"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.sg_cidr]
    }
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-sg_public"
  }
}

resource "aws_security_group" "dev_pro_sg_private" {
  name   = "Security Group for Private Subnets"
  vpc_id = aws_vpc.dev_pro_vpc.id

  dynamic "ingress" {
    for_each = ["22", "80"]
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
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-sg_private"
  }
}

resource "aws_security_group" "dev_pro_sg_database" {
  name   = "Security Group for Database Subnets"
  vpc_id = aws_vpc.dev_pro_vpc.id

  dynamic "ingress" {
    for_each = ["22", "3306"]
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
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-sg_database"
  }
}
