resource "aws_vpc" "lb_vpc" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "lb_vpc"
  }
}

resource "aws_internet_gateway" "lb_gateway" {
  vpc_id = aws_vpc.lb_vpc.id
}

resource "aws_subnet" "lb_subnet1" {
  vpc_id = aws_vpc.lb_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-2a"
}

resource "aws_subnet" "lb_subnet2" {
  vpc_id = aws_vpc.lb_vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-2b"
}
