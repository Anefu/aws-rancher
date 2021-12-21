variable "creds_output_path" {
  type        = string
  description = "Path to save credentials (SSH keys and kubeconfig)"
  default     = "./"
}

variable "rancher_domain" {
  type        = string
  description = "Domain name to use for rancher"
}

variable "cluster_name" {
  type        = string
  description = "Name for the Rancher cluster"
}

variable "certmanager_version" {
  type        = string
  description = "Version of cert manager to use"
  default     = "1.6.1"
}

variable "certmanager_chart" {
  type        = string
  description = "Cert manager chart to use"
  default     = "cert-manager"
}

variable "rancher_chart" {
  type        = string
  description = "Rancher chart to use"
  default     = "rancher"
}

variable "rancher_version" {
  type        = string
  description = "Version of Rancher to install"
  default     = "2.6.0"
}

variable "le_email" {
  type        = string
  description = "Email of LetsEncrypt account"
}

variable "environment" {
  type        = string
  description = "Environment. Can only be staging or prod"
  default     = "production"
}

variable "rancher_password" {
  type        = string
  description = "Password for admin"
}

variable "node_asg" {
  type        = string
  description = "ASG name of nodes"
}
variable "instance_ssh_user" {
  type        = string
  description = "SSH user to connect to the instances as"
  default     = "ubuntu"
}

variable "node_count" {
  type        = number
  description = "Number of created master nodes"
}

variable "ldap_server" {
  type        = string
  description = "LDAP Server"
}

variable "service_account_dn" {
  type        = string
  description = "Service Account Distinguished Name"
}

variable "service_account_password" {
  type        = string
  description = "Service account password"
}

variable "user_search_base" {
  type        = string
  description = "User Search Base"
}

variable "ldap_port" {
  type        = number
  description = "LDAP Port"
  default     = 389
}

variable "ldap_test_username" {
  type        = string
  description = "Username to test LDAP connection with"
}

variable "ldap_test_password" {
  type        = string
  description = "Password for test user"
}

variable "access_mode" {
  type        = string
  description = "LDAP Access Mode"
  default     = "unrestricted"
}