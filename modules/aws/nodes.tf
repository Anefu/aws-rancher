resource "aws_launch_template" "rancher" {
  name          = "${var.cluster_name}-master-nodes"
  image_id      = var.ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.ssh.key_name
  iam_instance_profile {
    name = aws_iam_instance_profile.profile.name
  }
  user_data = base64encode("${path.module}/files/install-docker.sh")
  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      encrypted   = true
      volume_type = "gp2"
      volume_size = var.ebs_size
    }
  }
  vpc_security_group_ids = [aws_security_group.rancher.id]
  tag_specifications {
    resource_type = "instance"
    tags = {
      "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    }
  }

  tags = merge({
    Name = "${var.cluster_name}-master"
  }, var.common_tags)
}

resource "aws_autoscaling_group" "rancher" {
  name_prefix         = "${var.cluster_name}-master"
  desired_capacity    = var.node_count
  max_size            = var.max_count
  min_size            = var.node_count
  target_group_arns   = [aws_lb_target_group.rancher_api.arn]
  vpc_zone_identifier = aws_subnet.rancher_subnets[*].id

  launch_template {
    id      = aws_launch_template.rancher.id
    version = "$Latest"
  }
}

data "aws_instances" "rancher_master" {
  filter {
    name   = "tag:aws:autoscaling:groupName"
    values = [aws_autoscaling_group.rancher.name]
  }
}