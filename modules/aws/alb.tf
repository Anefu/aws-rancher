resource "aws_lb" "rancher_api" {
  name        = "${var.cluster_name}-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = aws_subnet.rancher_master_subnets[*].id

  enable_deletion_protection = true

  tags = merge({ Name = "${var.cluster_name}-api" }, var.common_tags)
}

resource "aws_lb_listener" "rancher_api_https" {
  load_balancer_arn = aws_lb.rancher_api.arn
  port              = "443"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.rancher_api.arn
  }
}

resource "aws_lb_listener" "rancher_api_https2" {
  load_balancer_arn = aws_lb.rancher_api.arn
  port              = "6443"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.rancher_api.arn
  }
}

resource "aws_lb_target_group" "rancher_api" {
  name = "${var.cluster_name}-master-tg"
  port        = 6443
  protocol    = "TCP"
  vpc_id      = aws_vpc.rancher_vpc.id
}


resource "aws_lb" "rancher" {
  name        = "${var.cluster_name}-worker"
  internal           = false
  subnets            = aws_subnet.rancher_master_subnets[*].id

  enable_deletion_protection = true

  tags = merge({ Name = "${var.cluster_name}-api" }, var.common_tags)
}

resource "aws_lb_target_group" "rancher_tg" {
  name = "${var.cluster_name}-worker-tg"
  port        = 443
  protocol    = "TCP"
  vpc_id      = aws_vpc.rancher_vpc.id
}


resource "aws_lb_listener" "rancher_worker" {
  load_balancer_arn = aws_lb.rancher.arn
  port              = "443"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.rancher_tg.arn
  }
}