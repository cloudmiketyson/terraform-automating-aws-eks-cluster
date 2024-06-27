terraform {
  backend "s3" {
  bucket = "eksdemo-state-bucket"  
    dynamodb_table = "eksdemo-lock-table"
    region = "us-east-1"
    key = "stage/eks.tfstate"
    encrypt = true
  }
}
