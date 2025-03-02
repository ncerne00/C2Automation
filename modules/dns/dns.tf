resource "aws_route53_zone" "primary" {
  name = var.domain
}

resource "aws_route53_record" "redirector_server_record" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = var.domain
  type    = "A"
  ttl     = 300
  records = [var.redirector_public_ip]
}

resource "aws_route53_record" "c2_server_record" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = var.c2_domain
  type    = "A"
  ttl     = 300
  records = [var.c2_public_ip]
}