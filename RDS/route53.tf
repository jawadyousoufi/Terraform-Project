resource "aws_route53_record" "reader1" {
  zone_id = "Z06411543BAX9LYP3T556"
  name    = "reader1.awsjawad.com"
  type    = "A"
  ttl     = "300"
  records = ["127.0.0.1"]
}

resource "aws_route53_record" "reader2" {
  zone_id = "Z06411543BAX9LYP3T556"
  name    = "reader2.awsjawad.com"
  type    = "A"
  ttl     = "300"
  records = ["127.0.0.1"]
}
resource "aws_route53_record" "reader3" {
  zone_id = "Z06411543BAX9LYP3T556"
  name    = "reader3.awsjawad.com"
  type    = "A"
  ttl     = "300"
  records = ["127.0.0.1"]
}
resource "aws_route53_record" "writer" {
  zone_id = "Z06411543BAX9LYP3T556"
  name    = "writer.awsjawad.com"
  type    = "A"
  ttl     = "300"
  records = ["127.0.0.1"]
}