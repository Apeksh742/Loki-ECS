resource "aws_security_group" "loki_security_group" {
  name_prefix = var.service_name
  
  ingress {
    from_port = var.container_port
    to_port   = var.container_port
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

# resource "aws_security_group_rule" "ingress_rule_for_lb" {
#   type        = "ingress"
#   from_port   = var.container_port
#   to_port     = var.container_port
#   protocol    = "tcp"
#   cidr_blocks = ["0.0.0.0/0"]
#   security_group_id = data.aws_security_group.load_balancer_sg.id
# }