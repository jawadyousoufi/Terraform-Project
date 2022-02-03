resource "aws_rds_cluster_instance" "reader1" {
  apply_immediately  = true
  cluster_identifier = aws_rds_cluster.default.id
  identifier         = "test1"
  instance_class     = "db.t2.small"
  engine             = aws_rds_cluster.default.engine
  engine_version     = aws_rds_cluster.default.engine_version
}

resource "aws_rds_cluster_instance" "reader2" {
  apply_immediately  = true
  cluster_identifier = aws_rds_cluster.default.id
  identifier         = "test2"
  instance_class     = "db.t2.small"
  engine             = aws_rds_cluster.default.engine
  engine_version     = aws_rds_cluster.default.engine_version
}

resource "aws_rds_cluster_instance" "reader3" {
  apply_immediately  = true
  cluster_identifier = aws_rds_cluster.default.id
  identifier         = "test3"
  instance_class     = "db.t2.small"
  engine             = aws_rds_cluster.default.engine
  engine_version     = aws_rds_cluster.default.engine_version
}
resource "aws_rds_cluster_instance" "writer" {
  apply_immediately  = true
  cluster_identifier = aws_rds_cluster.default.id
  identifier         = "test3"
  instance_class     = "db.t2.small"
  engine             = aws_rds_cluster.default.engine
  engine_version     = aws_rds_cluster.default.engine_version
}