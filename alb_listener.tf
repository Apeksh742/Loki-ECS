
resource "aws_lb_listener" "loki_http_listener" {
  load_balancer_arn = data.aws_lb.load_balancer.arn
  port              = var.container_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.loki_http.arn
  }
}