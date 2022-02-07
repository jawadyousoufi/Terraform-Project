resource "random_password" "password" { #A
  length           = 16
  special          = true
  override_special = "_%@/'\""
}
resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"
  identifier           = "${var.namespace}-db-instance"
  name                 = "team1"
  username             = "admin"
  password             = "password"
  db_subnet_group_name = var.vpc.database_subnet_group #ask farukh
  vpc_security_group_ids = [var.sg.db]
  skip_final_snapshot  = true
}
