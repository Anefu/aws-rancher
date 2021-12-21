resource "rke_cluster" "rancher_server" {

  dynamic "nodes" {
    for_each = data.aws_instance.rancher[*]
    content {
      address          = nodes.value.public_ip
      internal_address = nodes.value.private_ip
      user             = var.instance_ssh_user
      role             = ["controlplane", "etcd", "worker"]
      ssh_key          = "${var.creds_output_path}/id_rsa"
    }
  }

  cluster_name = var.cluster_name
  cloud_provider {
    name = "aws"
    aws_cloud_provider {
      global {
        kubernetes_cluster_id = var.cluster_name
      }
    }
  }
}

