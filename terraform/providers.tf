terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  required_version = ">= 1.16.0"
}

provider "aws" {
  region  = "eu-west-2"
  profile = "aws-portfolio"
}

provider "aws" {
  alias   = "us_east_1"
  region  = "us-east-1"
  profile = "aws-portfolio"
}