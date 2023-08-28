resource "aws_cloudwatch_log_group" "loki_s3" {
  name = "/ecs/${var.service_name}"

  tags = {
    Name        = "${var.service_name}-s3"
  }
}