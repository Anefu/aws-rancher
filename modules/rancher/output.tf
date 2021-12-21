resource "local_file" "kube_config_workload_yaml" {
  filename = format("%s/%s", path.root, "kube_config_workload.yaml")
  content  = rke_cluster.rancher_server.kube_config_yaml
}
