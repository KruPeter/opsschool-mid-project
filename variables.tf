terraform {
  required_version = ">= 0.12.0"
}

variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}