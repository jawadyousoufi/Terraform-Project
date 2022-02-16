resource "aws_route53_record" "www" {
zone_id = var.zone_id
name    = "wordpress."
type    = "CNAME"
ttl     = "300"
records = [aws_db_instance.default.address]
}