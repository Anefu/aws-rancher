resource "null_resource" "wait_for_docker" {
  count = var.master_node_count + var.worker_node_count

  triggers = {
    instance_ids = join(",", concat(data.aws_instances.rancher_worker.ids, data.aws_instances.rancher_master.ids))
  }

  provisioner "local-exec" {
    command = <<EOF
while [ "$${RET}" -gt 0 ]; do
    ssh -q -o StrictHostKeyChecking=no -i $${KEY} $${USER}@$${IP} 'docker ps 2>&1 >/dev/null'
    RET=$?
    if [ "$${RET}" -gt 0 ]; then
        sleep 10
    fi
done
EOF


    environment = {
      RET  = "1"
      USER = var.instance_ssh_user
      IP   = element(concat(data.aws_instances.rancher_master.public_ips, data.aws_instances.rancher_worker.public_ips), count.index)
      KEY  = "${var.creds_output_path}/id_rsa"
    }
  }
}

resource "rke_cluster" "rancher_server" {
  depends_on = [null_resource.wait_for_docker]

  # mappings = {
  #     "${count.index}": ["${master_node_public_ips[count.index]}", "${master_node_private_ips[count.index]}"]
  #   }

  dynamic nodes {
    for_each = data.aws_instance.master[*]
    content {
      address          = nodes.value.public_ip
      internal_address = nodes.value.private_ip
      user             = var.instance_ssh_user
      role             = ["controlplane", "etcd"]
      ssh_key          = "${var.creds_output_path}/id_rsa"
    }
  }

  dynamic nodes {
    for_each = data.aws_instance.worker[*]
    content {
      address          = nodes.value.public_ip
      internal_address = nodes.value.private_ip
      user             = var.instance_ssh_user
      role             = ["worker"]
      ssh_key          = "${var.creds_output_path}/id_rsa"
    }
  }

  cluster_name = var.cluster_name
  #addons       = file("${path.module}/files/addons.yaml")

  authentication {
    strategy = "x509"

    sans = [
      var.cluster_dns
    ]
  }
  cloud_provider {
    name = "aws"
    aws_cloud_provider {
      global {
        kubernetes_cluster_id = "${var.cluster_name}"
      }
    }
  }


resource "local_file" "kube_cluster_yaml" {
  filename = "${path.root}/outputs/kube_config_cluster.yaml"
  content = templatefile("${path.module}/files/kube_config_cluster.yaml", {
    api_server_url     = var.cluster_dns
    rancher_cluster_ca = base64encode(rke_cluster.rancher_server.ca_crt)
    rancher_user_cert  = base64encode(rke_cluster.rancher_server.client_cert)
    rancher_user_key   = base64encode(rke_cluster.rancher_server.client_key)
    cluster_name = var.cluster_name
  })
}