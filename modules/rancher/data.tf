data "aws_instance" "rancher" {
  count = var.node_count
  filter {
    name   = "tag:aws:autoscaling:groupName"
    values = [var.node_asg]
  }
}

