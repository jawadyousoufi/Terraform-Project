resource "aws_route53_record" "reader1" {
  zone_id = "Z0131651J2KEHCW5QES6"
  name    = "reader1.tuncaytas.com"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.reader1.public_ip]
}

resource "aws_route53_record" "reader2" {
  zone_id = "Z0131651J2KEHCW5QES6"
  name    = "reader2.tuncaytas.com"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.reader2.public_ip]
}
resource "aws_route53_record" "reader3" {
  zone_id = "Z0131651J2KEHCW5QES6"
  name    = "reader3.tuncaytas.com"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.reader3.public_ip]
}
resource "aws_route53_record" "writer" {
  zone_id = "Z0131651J2KEHCW5QES6"
  name    = "writer.tuncaytas.com"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.writer.public_ip]
}