data "aws_security_group" "default" {
  vpc_id = "${aws_vpc.resource "aws_vpc" "VPC_Project" {
.id}"
  name   = "default_SG_mid_project"
}

resource "aws_security_group" "VPC_Project-default" {
  name        = "mid-project-default"
  description = "default VPC mid project security group"
  vpc_id      = "${aws_vpc.resource "aws_vpc" "VPC_Project" {
.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}