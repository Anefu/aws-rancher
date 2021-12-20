provider "aws" {
  region = "us-east-1"
}

module "aws" {
  source               = "./modules/aws"
  aws_region           = var.aws_region
  cluster_name         = var.cluster_name
  master_subnets_count = var.master_subnets_count
  cidr_block           = var.cidr_block
  worker_subnets_count = var.worker_subnets_count
  creds_output_path    = var.creds_output_path
  r53_zone_name        = var.r53_zone_name
  common_tags          = var.common_tags
  ami                  = var.ami
  master_instance_type = var.master_instance_type
  master_ebs_size      = var.master_ebs_size
  worker_instance_type = var.worker_instance_type
  worker_ebs_size      = var.worker_ebs_size
  master_node_count    = var.master_node_count
  master_max_count     = var.master_max_count
  worker_node_count    = var.worker_node_count
  worker_max_count     = var.worker_max_count
  cluster_dns          = var.cluster_dns
}

module "rancher" {
  source                   = "./modules/rancher"
  cluster_dns              = module.aws.api_url
  master_asg               = module.aws.master_asg
  worker_asg               = module.aws.worker_asg
  master_node_count        = var.master_node_count
  worker_node_count        = var.worker_node_count
  cluster_name             = var.cluster_name
  le_email                 = var.le_email
  rancher_password         = var.rancher_password
  ldap_server              = var.ldap_server
  service_account_dn       = var.service_account_dn
  service_account_password = var.service_account_password
  user_search_base         = var.user_search_base
  ldap_test_username       = var.ldap_test_username
  ldap_test_password       = var.ldap_test_password
}