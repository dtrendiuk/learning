# ALB
resource "aws_alb" "dev_pro_alb" {
  name            = var.alb_name
  subnets         = [aws_subnet.dev_pro_public_subnets[0].id, aws_subnet.dev_pro_public_subnets[1].id]
  security_groups = [aws_security_group.dev_pro_sg_public.id]

  tags = {
    Name = "${var.env}-alb"
  }
}

resource "aws_alb_listener" "dev_pro_alb_listener" {
  load_balancer_arn = aws_alb.dev_pro_alb.arn
  port              = var.aws_lb_listener_port
  protocol          = var.aws_lb_listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.dev_pro_tg_1.arn
  }
}

resource "aws_lb_listener_rule" "dev_pro_listener_rule" {
  listener_arn = aws_alb_listener.dev_pro_alb_listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.dev_pro_tg_2.arn
  }

  condition {
    path_pattern {
      values = ["/phpmyadmin/*"]
    }
  }
}

# Target groups
resource "aws_alb_target_group" "dev_pro_tg_1" {
  name     = var.tg_1_name
  port     = var.tg_1_port
  protocol = var.tg_1_protocol
  vpc_id   = aws_vpc.dev_pro_vpc.id

  tags = {
    Name = "${var.env}-tg-1"
  }

  health_check {
    path = "/index.html"
  }
}

resource "aws_alb_target_group" "dev_pro_tg_2" {
  name     = var.tg_2_name
  port     = var.tg_2_port
  protocol = var.tg_2_protocol
  vpc_id   = aws_vpc.dev_pro_vpc.id

  tags = {
    Name = "${var.env}-tg-2"
  }

  health_check {
    path = "/phpmyadmin/"
  }
}

resource "aws_alb_target_group_attachment" "dev_pro_tg_1_1" {
  target_group_arn = aws_alb_target_group.dev_pro_tg_1.arn
  target_id        = aws_instance.dev_pro_webserver_1.id
}

resource "aws_alb_target_group_attachment" "dev_pro_tg_1_2" {
  target_group_arn = aws_alb_target_group.dev_pro_tg_1.arn
  target_id        = aws_instance.dev_pro_webserver_2.id
}

resource "aws_alb_target_group_attachment" "dev_pro_tg_2" {
  count            = length(aws_instance.dev_pro_phpmyadmin)
  target_group_arn = aws_alb_target_group.dev_pro_tg_2.arn
  target_id        = aws_instance.dev_pro_phpmyadmin[count.index].id
}

# CloudWatch dashboard
resource "aws_cloudwatch_dashboard" "dev_pro_alb_cloudwatch" {
  dashboard_name = "dev-pro-alb"

  dashboard_body = <<EOF
  {
    "widgets": [
        {
            "type": "metric",
            "x": 0,
            "y": 0,
            "width": 6,
            "height": 6,
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
          [ "AWS/ApplicationELB",
            "HTTPCode_Target_2XX_Count",
            "TargetGroup",
            "${aws_alb_target_group.dev_pro_tg_1.arn_suffix}",
            "${aws_alb_target_group.dev_pro_tg_2.arn_suffix}",
            "LoadBalancer" ]
        ],
                "region": "var.region"
            }
        }
    ]
}
EOF
}
