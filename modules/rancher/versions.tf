terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.4.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }
    rancher2 = {
      source  = "rancher/rancher2"
      version = "1.21.0"
    }
    rke = {
      source  = "rancher/rke"
      version = "1.2.5"
    }
  }
  required_version = ">= 1.0.0"
}
