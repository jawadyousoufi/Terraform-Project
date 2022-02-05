resource "aws_route53_record" "web" {
  zone_id = "Z07704841T92HRZROB0JL"
  name    = "wordpress.russianese.com"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.wp_lb.public_ip]
}