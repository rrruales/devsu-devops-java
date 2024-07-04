terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.36.0"
    }
  }

  backend "s3" {
    bucket = "devsu-devops-java"
    key    = "vpc/terraform.tfstate"
    region = "us-east-1"
  }

  required_version = "1.6.6"
}

provider "aws" {
  region = "us-east-1"
}
