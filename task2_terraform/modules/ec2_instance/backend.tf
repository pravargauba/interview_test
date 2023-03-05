terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = ""
    workspaces {
      prefix = ""
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  required_version = "1.3.5"
}