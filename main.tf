resource "aws_ecs_service" "loki_service" {
  name                              = var.service_name
  cluster                           = data.aws_ecs_cluster.cicd_cluster.arn
  task_definition                   = aws_ecs_task_definition.loki_task_definition.arn
  force_new_deployment              = true
  desired_count                     = var.service_count
  launch_type                       = "FARGATE"
  platform_version                  = "LATEST"
  health_check_grace_period_seconds = 60
  network_configuration {
    subnets          = ["subnet-0a1d10d93df720021", "subnet-0507b04a3d8fb2da1"]
    security_groups  = [aws_security_group.loki_security_group.id]
    assign_public_ip = true
  }


  load_balancer {
    target_group_arn = aws_lb_target_group.loki_http.arn
    container_name   = var.service_name
    container_port   = var.container_port
  }

  # service_registries {
  #   registry_arn = aws_service_discovery_service.blackbox_service_discovery_svc.arn
  # }

}
