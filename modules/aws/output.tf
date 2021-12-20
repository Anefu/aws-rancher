output "api_url" {
  value = aws_route53_record.rancher_api.fqdn
}

output "master_asg" {
  value = aws_autoscaling_group.rancher_master.name
}

output "worker_asg" {
  value = aws_autoscaling_group.rancher_worker.name
}
