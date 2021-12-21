
resource "aws_route53_record" "rancher_api" {
  zone_id  = "data.aws_route53_zone.${var.r53_zone_name}.zone_id"
  name     = var.rancher_domain
  ttl      = 60
  type     = "CNAME"
  provider = aws.r53
  records  = [aws_lb.rancher_api.dns_name]
}
