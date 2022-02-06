resource "aws_route53_record" "reader1-live" {
  zone_id = "Z0131651J2KEHCW5QES6"
  name    = "reader1"
  type    = "A"
  ttl     = "300"
   set_identifier = "live"
  records        = ["reader1.tuncaytas.com"]
}

resource "aws_route53_record" "reader2-live" {
  zone_id = "Z0131651J2KEHCW5QES6"
  name    = "reader2"
  type    = "A"
  ttl     = "300"
     set_identifier = "live"
  records        = ["reader2.tuncaytas.com"]
}
resource "aws_route53_record" "reader3-live" {
  zone_id = "Z0131651J2KEHCW5QES6"
  name    = "reader3"
  type    = "A"
  ttl     = "300"
     set_identifier = "live"
  records        = ["reader3.tuncaytas.com"]
}
resource "aws_route53_record" "writer-live" {
  zone_id = "Z0131651J2KEHCW5QES6"
  name    = "writer"
  type    = "A"
  ttl     = "300"
     set_identifier = "live"
  records        = ["writer.tuncaytas.com"]
}