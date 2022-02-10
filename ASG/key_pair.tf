# This code is creating key-pair
resource "aws_key_pair" "wordpress_key" {
  key_name_prefix   = "wordpress_key-"
  public_key = file("~/.ssh/id_rsa.pub")
}