provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      # version = "< 5.0"
    }
     kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">3.0.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">2.4.1"
    }
  }
  
}
