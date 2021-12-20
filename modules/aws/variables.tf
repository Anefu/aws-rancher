variable "aws_region" {
    type = string
    description = "AWS Region to create resources in"
    default = "us-east-1"
}
variable "cluster_name" {
    type = string
    description = "Name for the Rancher cluster"
}

variable "master_subnets_count" {
    type = number
    description = "Number of subnets to create for worker nodes"
}

variable "cidr_block" {
    type = string
    description = "CIDR Block to use for VPC"
}

variable "worker_subnets_count" {
    type = number
    description = "Number of subnets to create for worker nodes"
}

variable "creds_output_path" {
    type = string
    description = "Path to save credentials (SSH keys and kubeconfig)"
    default = "./"
}

variable "r53_zone_name" {
    type = string
    description = "Name of Route 53 hosted zone"
}

variable "common_tags" {
    type = map(string)
    description = "Tags for the cluster"
    default = {
        Environment = "prod"
    }
}

variable "ami" {
    type = string
    description = "AMI to use for master nodes"
}

variable "master_instance_type" {
    type = string
    description = "Instance type to use for master nodes"
}

variable "master_ebs_size" {
    type = number
    description = "Size of EBS volume for master nodes"
}

variable "worker_instance_type" {
    type = string
    description = "Instance type to use for worker nodes"
}

variable "worker_ebs_size" {
    type = number
    description = "Size of EBS volume for worker nodes"
}

variable "master_node_count" {
    type = number
    description = "Number of master node instances to create"
}

variable "master_max_count" {
    type = number
    description = "Maximum size of master autoscaling group"
}

variable "worker_node_count" {
    type = number
    description = "Minimum number of worker node instances to create"
}

variable "worker_max_count" {
    type = number
    description = "Maximum number of worker node instances to create"
}

variable "cluster_dns" {
    type = string
    description = "Route 53 zone name"
}
