provider "rke" {
  log_file = "./log_file"
}

provider "helm" {
  kubernetes {
    config_path = local_file.kube_cluster_yaml.filename
  }
}

provider "rancher2" {
  alias     = "bootstrap"
  api_url   = var.cluster_dns
  bootstrap = true
}

provider "rancher2" {
  api_url   = var.cluster_dns
  token_key = rancher2_bootstrap.admin.token
}