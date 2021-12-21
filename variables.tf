variable "aws_region" {
  type        = string
  description = "AWS Region to create resources in"
  default     = "us-east-1"
}
variable "cluster_name" {
  type        = string
  description = "Name for the Rancher cluster"
}

variable "subnets_count" {
  type        = number
  description = "Number of subnets to create for worker nodes"
}

variable "cidr_block" {
  type        = string
  description = "CIDR Block to use for VPC"
}

variable "creds_output_path" {
  type        = string
  description = "Path to save credentials (SSH keys and kubeconfig)"
  default     = "./"
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

variable "instance_type" {
  type        = string
  description = "Instance type to use for master nodes"
}

variable "ebs_size" {
  type        = number
  description = "Size of EBS volume for master nodes"
}

variable "node_count" {
  type        = number
  description = "Number of node instances to create"
}

variable "max_count" {
  type        = number
  description = "Maximum size of autoscaling group"
}

variable "rancher_domain" {
  type        = string
  description = "Route 53 zone name"
}

variable "instance_ssh_user" {
  type        = string
  description = "SSH user to connect to the instances as"
  default     = "ubuntu"
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
variable "le_email" {
  type        = string
  description = "LetsEncrypt Email"
}

variable "rancher_password" {
  type        = string
  description = "Password to use for the Rancher server"
}