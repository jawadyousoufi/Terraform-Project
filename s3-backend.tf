terraform {
  backend "s3" {
    bucket = "terraform-project-group1"
    key    = "group1/module/wordpress"
    region = "us-east-1"
  }
}