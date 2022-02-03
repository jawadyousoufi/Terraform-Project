resource "aws_subnet" "private1" {
  vpc_id                  = aws_vpc.project1.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "private1"
  }
}

resource "aws_subnet" "private2" {
  vpc_id                  = aws_vpc.project1.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
  tags = {
    Name = "private2"
  }
}

resource "aws_subnet" "private3" {
  vpc_id                  = aws_vpc.project1.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1c"
  tags = {
    Name = "private3"
  }
}