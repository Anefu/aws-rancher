# resource "aws_route53_record" "rancher" {
#   zone_id  = "data.aws_route53_zone.${var.r53_zone_name}.zone_id"
#   name     = "${local.name}.${local.domain}"
#   type     = "A"
#   provider = aws.r53

#   alias {
#     name                   = aws_elb.rancher.dns_name
#     zone_id                = aws_elb.rancher.zone_id
#     evaluate_target_health = true
#   }
# }

resource "aws_route53_record" "rancher_api" {
  zone_id  = "data.aws_route53_zone.${var.r53_zone_name}.zone_id"
  name     = var.cluster_dns
  ttl      = 60
  type     = "CNAME"
  provider = aws.r53
  records  = [aws_lb.rancher_api.dns_name]
}
