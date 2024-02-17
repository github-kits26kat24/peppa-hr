resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.prod.id # aws_vpc.hr-app-vpc.id
  tags = {
    Name = "main"
  }
}