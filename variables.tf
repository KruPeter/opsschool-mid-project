terraform {
  required_version = ">= 0.12.0"
}

variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "consul_version" {
  description = "The version of Consul to install (server and client)."
  default     = "1.4.0"
}

