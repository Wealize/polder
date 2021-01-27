terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = "eu-central-1"
}

variable "aws_access_key" {
  default = ""
}

variable "aws_secret_key" {
  default = ""
}
