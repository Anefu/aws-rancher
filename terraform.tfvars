# AWS vars
aws_region        = "us-east-1"
cluster_name      = "blas"
subnets_count     = 1
cidr_block        = "10.0.0.0/16"
creds_output_path = "~/Documents/aws-rancher"
r53_zone_name     = "tooling.tk"
common_tags = {
  Name = "Rancher"
}
ami            = "ami-0b0af3577fe5e3532"
instance_type  = "value"
ebs_size       = 1
node_count     = 1 # should be an odd number
max_count      = 3
rancher_domain = "example.com"

#Rancher vars
le_email                 = "example@gmail.com"
rancher_password         = "rancher"
ldap_server              = "value"
service_account_dn       = ""
service_account_password = ""
user_search_base         = ""
ldap_test_username       = ""
ldap_test_password       = ""