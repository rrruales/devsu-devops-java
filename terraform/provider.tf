terraform {
  required_providers {
    aws = {
        source = "hashicorpo/aws"
        version = "~> 5.36.0"
    }
  }

  backend "s3" {
    bucket = "devsu"
    key = "vpc/terraform.tfstate"
    region = "us-east-1"
  }

  required_version = "1.6.6"
}

provider "aws" {
  region = "us-east-1"
}