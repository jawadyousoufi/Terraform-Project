resource "aws_vpc" "project1" {
  cidr_block = "10.0.0.0/16"
  tags       = local.common_tags

}