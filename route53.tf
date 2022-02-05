resource "aws_route53_record" "www-live" {
  zone_id = "Z0131651J2KEHCW5QES6"
  name    = "www"
  type    = "A"
  ttl     = "300"
   set_identifier = "live"
  records        = ["reader1.tuncaytas.com"]
}

resource "aws_route53_record" "www-live" {
  zone_id = "Z0131651J2KEHCW5QES6"
  name    = "www"
  type    = "A"
  ttl     = "300"
     set_identifier = "live"
  records        = ["reader2.tuncaytas.com"]
}
resource "aws_route53_record" "www-live" {
  zone_id = "Z0131651J2KEHCW5QES6"
  name    = "www"
  type    = "A"
  ttl     = "300"
     set_identifier = "live"
  records        = ["reader3.tuncaytas.com"]
}
resource "aws_route53_record" "www-live" {
  zone_id = "Z0131651J2KEHCW5QES6"
  name    = "www"
  type    = "A"
  ttl     = "300"
     set_identifier = "live"
  records        = ["reader1.tuncaytas.com"]
}