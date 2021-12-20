provider "aws" {
  region  = "us-east-1"
}

module "aws" {
  source               = "./modules/aws"
  aws_region           = "us-east-1"
  cluster_name         = "blas"
  master_subnets_count = 1
  cidr_block           = "10.0.0.0/16"
  worker_subnets_count = 1
  creds_output_path    = "~/Documents/aws-rancher"
  r53_zone_name        = "tooling.tk"
  common_tags = {
    Name = "Rancher"
  }
  ami                  = "ami-0b0af3577fe5e3532"
  master_instance_type = "t2.micro"
  master_ebs_size      = 50
  worker_instance_type = "t2.micro"
  worker_ebs_size      = 50
  master_node_count    = 1
  master_max_count     = 3
  worker_node_count    = 1
  worker_max_count     = 3
  cluster_dns          = "rancher.example.com"
}

module "rancher" {
  source = "./modules/rancher"
  # depends_on = [
  #   module.aws
  # ]
  cluster_dns      = module.aws.api_url
  master_asg = module.aws.master_asg
  worker_asg = module.aws.worker_asg
  master_node_count = 1
  worker_node_count = 1
  cluster_name     = "rancher.example.com"
  le_email         = "example@gmail.com"
  rancher_password = "rancher"
}