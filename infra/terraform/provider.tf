provider "aws" {
  region = var.aws_region
}

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  # Uncomment if you want to use local backend
  # backend "local" {
  #   path = "terraform.tfstate"
  # }
  # Or configure Terraform Cloud if you prefer
}
