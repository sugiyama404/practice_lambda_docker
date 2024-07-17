terraform {
  required_version = "=1.8.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "iam" {
  source   = "./modules/iam"
  app_name = var.app_name
}

# ECR
module "ecr" {
  source     = "./modules/ecr"
  image_name = var.image_name
  app_name   = var.app_name
}

# BASH
module "bash" {
  source     = "./modules/bash"
  region     = var.region
  image_name = var.image_name
}

module "lambda" {
  source                = "./modules/lambda"
  app_name              = var.app_name
  lambda_iam_role       = module.iam.lambda_iam_role
  lambda_function_name  = var.lambda_function_name
  region                = var.region
  lambda_repository_url = module.ecr.lambda_repository_url
}



