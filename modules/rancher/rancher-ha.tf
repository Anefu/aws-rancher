resource "null_resource" "cert-manager-crds" {
  depends_on = [
    rke_cluster.rancher_server
  ]
  provisioner "local-exec" {
    command = <<EOF
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v${var.certmanager_version}/cert-manager.crds.yaml
kubectl create namespace cert-manager
kubectl label namespace cert-manager certmanager.k8s.io/disable-validation=true
EOF


    environment = {
      KUBECONFIG = local_file.kube_config_workload_yaml.filename
    }
  }
}

# install cert-manager
resource "helm_release" "cert_manager" {
  depends_on = [null_resource.cert-manager-crds]
  version    = "v${var.certmanager_version}"
  name       = "cert-manager"
  chart      = var.certmanager_chart
  namespace  = "cert-manager"
  repository = "https://charts.jetstack.io"

  # Bogus set to link together resources for proper tear down
  set {
    name  = "tf_link"
    value = rke_cluster.rancher_server.api_server_url
  }
}

# install rancher
resource "helm_release" "rancher" {
  name       = "rancher"
  chart      = var.rancher_chart
  version    = "v${var.rancher_version}"
  namespace  = "cattle-system"
  repository = "https://releases.rancher.com/server-charts/stable"

  set {
    name  = "hostname"
    value = var.rancher_domain
  }

  set {
    name  = "ingress.tls.source"
    value = "letsEncrypt"
  }

  set {
    name  = "letsEncrypt.email"
    value = var.le_email
  }

  set {
    name  = "letsEncrypt.environment"
    value = var.environment # valid options are 'staging' or 'production'
  }

  # Bogus set to link togeather resources for proper tear down
  set {
    name  = "tf_link"
    value = helm_release.cert_manager.name
  }
  set {
    name  = "bootstrapPassword"
    value = var.rancher_password
  }
}

resource "null_resource" "wait_for_rancher" {
  provisioner "local-exec" {
    command = <<EOF
while [ "$${subject}" != "*  subject: CN=$${RANCHER_HOSTNAME}" ]; do
    subject=$(curl -vk -m 2 "https://$${RANCHER_HOSTNAME}/ping" 2>&1 | grep "subject:")
    echo "Cert Subject Response: $${subject}"
    if [ "$${subject}" != "*  subject: CN=$${RANCHER_HOSTNAME}" ]; then
      sleep 10
    fi
done
while [ "$${resp}" != "pong" ]; do
    resp=$(curl -sSk -m 2 "https://$${RANCHER_HOSTNAME}/ping")
    echo "Rancher Response: $${resp}"
    if [ "$${resp}" != "pong" ]; then
      sleep 10
    fi
done
EOF


    environment = {
      RANCHER_HOSTNAME = "${var.rancher_domain}"
      TF_LINK          = helm_release.rancher.name
    }
  }
}

resource "rancher2_bootstrap" "admin" {
  provider = rancher2.bootstrap

  depends_on = [null_resource.wait_for_rancher]

  password = var.rancher_password
}