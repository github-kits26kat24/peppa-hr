data "aws_region" "current" {}
data "aws_caller_identity" "current" {}
data "aws_availability_zones" "working" {}
data "aws_vpcs" "vpcs" {}

#### Creating Latest AMI #### 
data "aws_ami" "latest_amazon_linux" {
  owners = ["137112412989"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023.3.20240205.2-kernel-6.1-x86_64*"]
  }
}

output "all_vpc_ids" {
  value = data.aws_vpcs.vpcs.ids
}

output "latest_ami" {
  value = data.aws_ami.latest_amazon_linux.id
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}

output "aws_region_name" {
  value = data.aws_region.current.name
}

output "aws_region_description" {
  value = data.aws_region.current.description
}

output "aws_region_endpoint" {
  value = data.aws_region.current.endpoint
}

output "aws_availability_zones" {
  value = data.aws_availability_zones.working.names
}