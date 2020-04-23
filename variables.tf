terraform {
  required_version = ">= 0.12.0"
}

variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable vpc_id {
  description = "AWS VPC id"
  default     = "vpc-04d684c73d66559bf"
}

variable "ip" {
  default = "109.66.225.222/32"
  description = "my private ip"
}

variable "consul_version" {
  description = "The version of Consul to install (server and client)."
  default     = "1.4.0"
}

