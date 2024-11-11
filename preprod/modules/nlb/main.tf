resource "aws_lb" "ecs_alb" {
  name               = var.lb_name
  internal           = var.internal
  load_balancer_type = "network"
  security_groups    = var.security_groups
  subnets            = var.subnets

  tags = var.tags
}

resource "aws_lb_listener" "tcp_listener" {
  load_balancer_arn = aws_lb.ecs_alb.arn
  port              = var.target_group_port
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg.arn
  }
}

resource "aws_lb_target_group" "ecs_tg" {
  name        = var.target_group_name
  port        = var.target_group_port
  protocol    = "TCP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    port                = "traffic-port"
    protocol            = "TCP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
  }
}
