provider "aws" {
  region = "us-east-1"
}

module "aws" {
  source            = "./modules/aws"
  aws_region        = var.aws_region
  cluster_name      = var.cluster_name
  subnets_count     = var.subnets_count
  cidr_block        = var.cidr_block
  creds_output_path = var.creds_output_path
  r53_zone_name     = var.r53_zone_name
  common_tags       = var.common_tags
  ami               = var.ami
  instance_type     = var.instance_type
  ebs_size          = var.ebs_size
  node_count        = var.node_count
  max_count         = var.max_count
  rancher_domain    = var.rancher_domain
}

module "rancher" {
  source                   = "./modules/rancher"
  rancher_domain           = module.aws.api_url
  node_asg                 = module.aws.rancher_asg
  node_count               = var.node_count
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