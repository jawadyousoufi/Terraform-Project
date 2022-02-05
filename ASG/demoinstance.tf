# Creating 1 EC2 instance in Public Subnet
resource "aws_instance" "demoinstance" {
  ami                         = var.aws_ami
  instance_type               = "t2.micro"
  count                       = 1
  key_name                    = "tests"
  vpc_security_group_ids      = ["${aws_security_group.wp_sec_group.id}"]
  subnet_id                   = "${aws_subnet.demoinstance.id}"
  associate_public_ip_address = true
  #user_data                   = "${file("data.sh")}"
tags = {
    Name = "My Public Instance"
  }
}