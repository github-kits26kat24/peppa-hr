resource "aws_subnet" "node-1" {
  vpc_id     = aws_vpc.prod.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Node-1"
    Info = "AZ: ${data.aws_availability_zones.working.names[0]} in Region: ${data.aws_region.current.description}"
  }
}

resource "aws_subnet" "node-2" {
  vpc_id     = aws_vpc.prod.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "Node-2"
    Info = "AZ: ${data.aws_availability_zones.working.names[0]} in Region: ${data.aws_region.current.description}"
  }
}

resource "aws_subnet" "monitoring" {
  vpc_id     = aws_vpc.prod.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "Monitoring"
    Info = "AZ: ${data.aws_availability_zones.working.names[0]} in Region: ${data.aws_region.current.description}"
  }
}