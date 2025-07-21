resource "aws_lb" "this" {
  name               = var.name
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = var.name
  }
}

resource "aws_lb_target_group" "this" {
  name     = "${var.name}-tg"
  port     = var.target_port  # Usamos la var para forwarding port
  protocol = var.target_protocol  # HTTP o HTTPS
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
    protocol            = var.target_protocol  # Matchea con el protocol del target
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.listener_port  # Usamos la var para listener port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}