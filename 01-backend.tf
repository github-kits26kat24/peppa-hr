terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "hr.bucket"
    key    = "dev"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-west-1"
  default_tags {
    tags = {
      Owner     = "Olukayode Tijani"
      CreatedBy = "Terraform"
      Job       = "Professional Farmers"
    }
  }
}