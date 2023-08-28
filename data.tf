data "aws_ecs_cluster" "cicd_cluster" {
  cluster_name = "cicd-cluster"
}

data "aws_lb" "load_balancer" {
  name = var.load_balancer_name
}

data "aws_security_group" "load_balancer_sg" {
  name = var.load_balancer_sg_name
}
