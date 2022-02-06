module "rds_cluster" {
  source  = "terraform-aws-modules/rds-aurora/aws"

  name           = "rds-cluster"
  engine         = "aurora-mysql"
  engine_version = "5.7"
  instance_class = "db.t2-micro"
  instances = {
    one = {}
    3 = {
      instance_class = "db.t2-micro"
    }
  }

  vpc_id  = "default-vpc"
  subnets = ["us-east-1a", "us-east-1b", "us-east-1c"]
  

  allowed_security_groups = ["sg-vpc"]
  allowed_cidr_blocks     = ["10.20.0.0/20"]

  storage_encrypted   = true
  apply_immediately   = true

  db_parameter_group_name         = "default"
  db_cluster_parameter_group_name = "default"


  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}