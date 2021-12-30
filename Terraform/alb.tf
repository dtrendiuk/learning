# ALB
resource "aws_alb" "dev_pro_alb" {
  name            = var.alb_name
  subnets         = [module.vpc.public_subnet_ids[0], module.vpc.public_subnet_ids[1]]
  security_groups = [module.vpc.sg_public_id]

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
  vpc_id   = module.vpc.vpc_id

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
  vpc_id   = module.vpc.vpc_id

  tags = {
    Name = "${var.env}-tg-2"
  }

  health_check {
    path = "/phpmyadmin/"
  }
}

resource "aws_alb_target_group_attachment" "dev_pro_tg_1_1" {
  target_group_arn = aws_alb_target_group.dev_pro_tg_1.arn
  target_id        = module.ec2-webserver1.instance[0]
}

resource "aws_alb_target_group_attachment" "dev_pro_tg_1_2" {
  target_group_arn = aws_alb_target_group.dev_pro_tg_1.arn
  target_id        = module.ec2-webserver2.instance[0]
}

resource "aws_alb_target_group_attachment" "dev_pro_tg_2" {
  target_group_arn = aws_alb_target_group.dev_pro_tg_2.arn
  target_id        = module.ec2-phpmyadmin.instance[0]
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
