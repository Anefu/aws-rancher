variable "aws_region" {
  type        = string
  description = "AWS Region to create resources in"
  default     = "us-east-1"
}
variable "cluster_name" {
  type        = string
  description = "Name for the Rancher cluster"
}

variable "master_subnets_count" {
  type        = number
  description = "Number of subnets to create for worker nodes"
}

variable "cidr_block" {
  type        = string
  description = "CIDR Block to use for VPC"
}

variable "worker_subnets_count" {
  type        = number
  description = "Number of subnets to create for worker nodes"
}

variable "r53_zone_name" {
  type        = string
  description = "Name of Route 53 hosted zone"
}

variable "common_tags" {
  type        = map(string)
  description = "Tags for the cluster"
  default = {
    Environment = "prod"
  }
}

variable "ami" {
  type        = string
  description = "AMI to use for master nodes"
}

variable "master_instance_type" {
  type        = string
  description = "Instance type to use for master nodes"
}

variable "master_ebs_size" {
  type        = number
  description = "Size of EBS volume for master nodes"
}

variable "worker_instance_type" {
  type        = string
  description = "Instance type to use for worker nodes"
}

variable "worker_ebs_size" {
  type        = number
  description = "Size of EBS volume for worker nodes"
}

variable "master_max_count" {
  type        = number
  description = "Maximum size of master autoscaling group"
}

variable "worker_max_count" {
  type        = number
  description = "Maximum number of worker node instances to create"
}

variable "cluster_dns" {
  type        = string
  description = "Route 53 zone name"
}


variable "certmanager_version" {
  type        = string
  description = "Version of cert manager to use"
  default     = "0.10.0"
}

variable "certmanager_chart" {
  type        = string
  description = "Cert manager chart to use"
  default     = "jetstack/cert-manager"
}

variable "rancher_chart" {
  type        = string
  description = "Rancher chart to use"
  default     = "rancher-stable/rancher"
}

variable "rancher_version" {
  type        = string
  description = "Version of Rancher to install"
  default     = "2.2.9"
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

variable "instance_ssh_user" {
  type        = string
  description = "SSH user to connect to the instances as"
  default     = "ubuntu"
}

variable "master_node_count" {
  type        = number
  description = "Number of created master nodes"
}

variable "worker_node_count" {
  type        = number
  description = "Number of created worker nodes"
}

variable "creds_output_path" {
  type        = string
  description = "Path to store credentials (SSH Key)"
  default     = "./"
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