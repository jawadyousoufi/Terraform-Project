resource "aws_route53_zone" "main" {
  name = "example.com"
}

resource "aws_route53_zone" "dev" {
  name = "dev.example.com"

  tags = {
    Environment = "dev"
  }
}

resource "aws_route53_record" "dev-ns" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "dev.example.com"
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.dev.name_servers
}




resource "aws_db_subnet_group" "db_subnet_group_name" {
  name       = var.db_subnet_group_name
  subnet_ids = [subnet-0bad6e22bdd18bdda, ]

  tags = {
    Name = "My DB subnet group"
  }
}







resource "aws_rds_cluster" "default" {
	cluster_identifier = var.identifier
	engine = var.engine
	engine_version = var.engine_version
	database_name = var.identifier
	master_username = var.username
	master_password = var.master_password
	db_subnet_group_name = var.db_subnet_group_name
	skip_final_snapshot = true #used to delete the repo in the future without this you cant delete. There are bugs reported 
	vpc_security_group_ids = [var.vpc_sg_id]
}


resource "aws_rds_cluster_instance" "cluster_instances" {
	count = 1
	identifier = "aurora-cluster-demo-${count.index +1}"
	cluster_identifier = var.identifier
	instance_class = "db.t2.small"
	engine_version = var.engine_version
	engine = var.engine
	publicly_accessible = var.publicly_accessible
	
}


resource "aws_rds_cluster_instance" "cluster_instances-reader" {
	count = 3
	identifier = "aurora-cluster-demo-reader-${count.index +3}"
	cluster_identifier = var.identifier
	instance_class = "db.t2.small"
	engine_version = var.engine_version
	engine = var.engine
	publicly_accessible = var.publicly_accessible
	
}