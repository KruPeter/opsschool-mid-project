# Setup the region in which to work.
provider "aws" {
    region = var.aws_region
}

# Create a VPC to run our system in

resource "aws_vpc" "VPC_Project" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"

  tags = {
	Name = "Terraform_VPC"
  }
}

# Take the list of availability zones
data "aws_availability_zones" "available" {}

resource "aws_internet_gateway" "IG_main" {
  vpc_id = "${aws_vpc.VPC_Project.id}"

  tags = {
    Name = "Terraform_IG"
  }
}