data "aws_security_group" "default" {
  vpc_id = "${aws_vpc.VPC_Project.id}"
  name   = "default"
}

resource "aws_security_group" "vpc-mid-project-default" {
  name        = "mid-project-default"
  description = "default VPC mid project security group"
  vpc_id      = "${aws_vpc.VPC_Project.id}"

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