terraform {
  backend "s3" {
    bucket         = "assignment-5-terraform-state-kashish"
    key            = "assignment-5/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "assignment-5-terraform-lock"
    encrypt        = true
  }
}