variable "creds_output_path" {
    type = string
    description = "Path to save credentials (SSH keys and kubeconfig)"
    default = "./"
}

variable "cluster_dns" {
    type = string
    description = "Route 53 zone name"
}

variable "cluster_name" {
    type = string
    description = "Name for the Rancher cluster"
}

variable "certmanager_version" {
  type = string
  description = "Version of cert manager to use"
  default = "0.10.0"
}

variable "certmanager_chart" {
    type = string
    description = "Cert manager chart to use"
    default = "jetstack/cert-manager"
}

variable "rancher_chart" {
  type = string
  description = "Rancher chart to use"
  default = "rancher-stable/rancher"
}

variable "rancher_version" {
  type = string
  description = "Version of Rancher to install"
  default = "2.2.9"
}

variable "le_email" {
    type = string
    description = "Email of LetsEncrypt account"
}

variable "environment" {
  type = string
  description = "Environment. Can only be staging or prod"
  default = "production"
}

variable "rancher_password" {
    type = string
    description = "Password for admin"
}

variable "worker_asg" {
  type = string
  description = "ASG name of worker nodes"
}
variable "master_asg" {
  type = string
  description = "ASG name of master nodes"
}

variable "instance_ssh_user" {
  type = string
  description = "SSH user to connect to the instances as"
  default = "ubuntu"
}

variable "master_node_count" {
  type = number
  description = "Number of created master nodes"
}

variable "worker_node_count" {
  type = number
  description = "Number of created worker nodes"
}