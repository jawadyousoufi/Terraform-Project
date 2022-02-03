resource "aws_security_group" "wp_sec_gr" {
  name        = "wp_sec_gr"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.project1.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.project1.cidr_block]
  }
ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.project1.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "wp_sec_gr"
    Team = "ProTeam"
    Env  = "Dev"
  }
}