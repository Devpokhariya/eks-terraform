resource "aws_ecs_service" "ecs_service" {
  name            = var.service_name
  cluster         = var.cluster_id
  task_definition = var.task_definition
  desired_count   = var.desired_count

  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_groups
    assign_public_ip = var.assign_public_ip
  }

  capacity_provider_strategy {
    capacity_provider = "FARGATE"
    weight            = 50
    base              = 20
  }

  lifecycle {
    ignore_changes = [triggers]
  }

  force_new_deployment              = var.force_new_deployment
  health_check_grace_period_seconds = var.health_check_grace_period_seconds

  dynamic "load_balancer" {
 for_each = var.target_group_arn != null && length(var.target_group_arn) == length(var.container_port) ? length(var.target_group_arn) == 1 ? { for tg in var.target_group_arn : tg => var.container_port[0] } : zipmap(var.target_group_arn, var.container_port): {}
    content {
      target_group_arn = load_balancer.key
      container_name   = var.container_name
      container_port   = load_balancer.value
    }
  }
}
