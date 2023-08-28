resource "aws_ecs_task_definition" "loki_task_definition" {
  family                   = var.service_name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = "arn:aws:iam::640726106943:role/ecsTaskExecutionRole"
  container_definitions = jsonencode([
    {
      name    = var.service_name
      image   = var.container_image
      command = ["-config.file=/etc/loki.yaml", "-target=all,table-manager"]
      portMappings = [
        {
          containerPort = var.container_port
          protocol      = "tcp"
        }
      ]
      "mountPoints" : [
        {
          "containerPath" : "/loki",
          "sourceVolume" : "loki-efs"
        }
      ],
      "logConfiguration" = {
        "logDriver" = "awslogs",
        "options" = {
          "awslogs-group"         = "${aws_cloudwatch_log_group.loki_s3.name}",
          "awslogs-region"        = "${var.region}",
          "awslogs-stream-prefix" = "ecs"
        }
      },
      environment : [
        {
          "name" : "AWS_ACCESS_KEY_ID",
          "value" : "AKIAZKLSAQM7SFONR4DO"
        },
        {
          "name" : "AWS_SECRET_ACCESS_KEY",
          "value" : "r74ns9YQSg/3/syLwDhB10sfH1CP8Jf14l/T7T0q"
        }
      ],
    }
  ])
  volume {
    name = "loki-efs"
    efs_volume_configuration {
      file_system_id = aws_efs_file_system.loki_efs.id
    }
  }
}
