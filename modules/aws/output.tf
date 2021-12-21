output "api_url" {
  value = aws_route53_record.rancher_api.fqdn
}

output "rancher_asg" {
  value = aws_autoscaling_group.rancher.name
}