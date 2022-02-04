# Terraform-Project Team 1 RDS
# Create 3 reader 1 writer cluster of 4 number of instances. Auto scaling enabled. 
## Resources created:
```
 module "rds cluster" {
  source  = "terraform-aws-modules/rds-aurora/aws"

  name           = "Team1-RDS"
  engine         = "mysql"
  engine_version = "5.7"
  instance_class = "db.t2-micro"
  instances = {
    one = {}
    3 = {
      instance_class = "t2-micro"
    }
  }
    
  ```