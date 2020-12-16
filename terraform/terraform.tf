terraform {
  required_version = ">= 0.12"
  backend "s3" {
    bucket = "polder-infra"
    key = "global/terraform.tfstate"
    region = "eu-central-1"
    dynamodb_table = "polder-infra-locks"
    encrypt = true
  }
}
