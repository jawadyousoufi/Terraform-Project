resource "aws_route53_record" "reader1" {
  zone_id = "Z0131651J2KEHCW5QES6"
  name    = "reader1.tuncaytas.com"
  type    = "A"
  ttl     = "300"
  records = [rds_cluster.Team1-RDS.public_ip]
}

resource "aws_route53_record" "reader2" {
  zone_id = "Z0131651J2KEHCW5QES6"
  name    = "reader2.tuncaytas.com"
  type    = "A"
  ttl     = "300"
  records = [rds_cluster.Team1-RDS.public_ip]
}
resource "aws_route53_record" "reader3" {
  zone_id = "Z0131651J2KEHCW5QES6"
  name    = "reader3.tuncaytas.com"
  type    = "A"
  ttl     = "300"
  records = [rds_cluster.Team1-RDS.public_ip]
}
resource "aws_route53_record" "writer" {
  zone_id = "Z0131651J2KEHCW5QES6"
  name    = "writer.tuncaytas.com"
  type    = "A"
  ttl     = "300"
  records = [rds_cluster.Team1-RDS.public_ip]
}