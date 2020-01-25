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

resource "aws_subnet" "private" {
  count                = "2"
  availability_zone    = "${element(data.aws_availability_zones.available.names, count.index)}"
  cidr_block           = "${cidrsubnet(aws_vpc.VPC_Project.cidr_block, 8, count.index)}"
  vpc_id               = "${aws_vpc.VPC_Project.id}"

  tags = {
    Name = "Subnet-private-${element(data.aws_availability_zones.available.names, count.index)}"
  }
}

resource "aws_subnet" "public" {
  count                      = "2"
  availability_zone          = "${element(data.aws_availability_zones.available.names, count.index)}"
  cidr_block                 = "${cidrsubnet(aws_vpc.VPC_Project.cidr_block, 8, count.index + length(data.aws_availability_zones.available.names))}"
  map_public_ip_on_launch    = true
  vpc_id                     = "${aws_vpc.VPC_Project.id}"

  tags = {
    Name = "Subnet-public-${element(data.aws_availability_zones.available.names, count.index)}"
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

resource "aws_eip" "nat" {
  count      = "2"
  vpc        = true
  depends_on = ["aws_internet_gateway.gw"]
}

resource "aws_nat_gateway" "gw" {
  count         = "2"
  allocation_id = "${element(aws_eip.nat.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"

  tags = {
    Name = "NAT tf-cluster-1 ${element(aws_subnet.public.*.availability_zone, count.index)}"
  }

  depends_on = ["aws_eip.nat"]
}

# Create public route tables
resource "aws_route_table" "public" {
  count = "2"
  vpc_id = "${aws_vpc.VPC_Project.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.IG_main.id}"
  }

  tags = {
    Name = "public tf-cluster ${element(aws_subnet.public.*.availability_zone, count.index)}"
  }
}

# Create private route tables
resource "aws_route_table" "private" {
  count  = "2"
  vpc_id = "${aws_vpc.experiment.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${element(aws_nat_gateway.gw.*.id, count.index)}"
  }

  tags = {
    Name    = "private tf-cluster ${element(aws_subnet.public.*.availability_zone, count.index)}"
    Service = "nat"
  }
}

# Route table association with public subnets
resource "aws_route_table_association" "public" {
  count          = "2"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.public.*.id, count.index)}"
}

# Route table association with private subnets
resource "aws_route_table_association" "private" {
  count          = "2"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
}