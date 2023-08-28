output "load_balancer_endpoint" {
  value = data.aws_lb.load_balancer.dns_name
}