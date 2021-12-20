data "aws_instances" "rancher_master" {
  filter {
    name   = "tag:aws:autoscaling:groupName"
    values = [var.master_asg]
  }
}

data "aws_instances" "rancher_worker" {
  filter {
    name   = "tag:aws:autoscaling:groupName"
    values = [var.worker_asg]
  }
}

data "aws_instance" "worker" {
  count = var.worker_node_count
  filter {
    name   = "tag:aws:autoscaling:groupName"
    values = [var.worker_asg]
  }
}

data "aws_instance" "master" {
  count = var.worker_node_count
  filter {
    name   = "tag:aws:autoscaling:groupName"
    values = [var.master_asg]
  }
}

