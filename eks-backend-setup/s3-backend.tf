provider "aws" {
  region = "us-east-1"
}


terraform {
  required_version = ">= 0.12"
  required_providers {

    aws = {
      source = "hashicorp/aws"

    }

  }
}

resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket        = "eksdemo-state-bucket"
  force_destroy = true

}


resource "aws_s3_bucket_versioning" "terraform-state-file-version" {
  bucket = aws_s3_bucket.terraform_state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_dynamodb_table" "terraform_lock" {
  name         = "eksdemo-lock-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "eks-lock-table"
  }
}


