# AWS vars
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

#Rancher vars
le_email         = "example@gmail.com"
rancher_password = "rancher"