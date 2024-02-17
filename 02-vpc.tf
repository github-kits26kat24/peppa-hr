# Create A New VPC
resource "aws_vpc" "prod" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "PROD"
  }
}


# data "aws_vpc" "prod" 