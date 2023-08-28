resource "aws_lb_target_group" "loki_http" {
  name        = "loki-http-tg"
  port        = var.container_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = "vpc-04411c9d7f2fd1e43"
  health_check {
    path                = "/ready"
    port                = var.container_port
    protocol            = "HTTP"
    interval            = 30
    timeout             = 10
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}


