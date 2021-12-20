resource "aws_launch_template" "rancher_master" {
  name = "${var.cluster_name}-master-nodes"
  image_id = var.ami
  instance_type = var.master_instance_type
  key_name = aws_key_pair.ssh.key_name

  user_data = base64encode("${path.module}/files/install-docker.sh")
	block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      encrypted   = true
      volume_type = "gp2"
      volume_size = var.master_ebs_size
    }
  }

  network_interfaces {
    delete_on_termination       = true
    security_groups             = [aws_security_group.rancher.id]
  }

  tags = merge({
		Name = "${var.cluster_name}-master"
	}, var.common_tags)
}

resource "aws_launch_template" "rancher_worker" {
  name   = "${var.cluster_name}-worker"
  image_id      = var.ami
  instance_type = var.worker_instance_type
  key_name = aws_key_pair.ssh.key_name

  user_data = base64encode("${path.module}/files/install-docker.sh")

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      encrypted   = true
      volume_type = "gp2"
      volume_size = var.worker_ebs_size
    }
  }

  network_interfaces {
    delete_on_termination       = true
    security_groups             = [aws_security_group.rancher.id]
  }

  tags = merge({
		Name = "${var.cluster_name}-master"
	}, var.common_tags)
}

resource "aws_autoscaling_group" "rancher_master" {
  name_prefix         = "${var.cluster_name}-master"
  desired_capacity    = var.master_node_count
  max_size            = var.master_max_count
  min_size            = var.master_node_count
  target_group_arns   = [aws_lb_target_group.rancher_api.arn]
  vpc_zone_identifier = aws_subnet.rancher_master_subnets[*].id 

  launch_template {
    id      = aws_launch_template.rancher_master.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_group" "rancher_worker" {
  name_prefix         = "${var.cluster_name}-worker"
  desired_capacity    = var.worker_node_count
  max_size            = var.worker_max_count
  min_size            = var.worker_node_count
  target_group_arns = [aws_lb_target_group.rancher_tg.arn]
  vpc_zone_identifier = aws_subnet.rancher_worker_subnets[*].id

  launch_template {
    id      = aws_launch_template.rancher_worker.id
    version = "$Latest"
  }
}

data "aws_instances" "rancher_master" {
  filter {
    name   = "tag:aws:autoscaling:groupName"
    values = [aws_autoscaling_group.rancher_master.name]
  }
}

data "aws_instances" "rancher_worker" {
  filter {
    name   = "tag:aws:autoscaling:groupName"
    values = [aws_autoscaling_group.rancher_worker.name]
  }
}