terraform {
  backend "s3" {
    bucket         = "kubernimbus-state"
    key            = "global/s3/network/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "kubernimbus-network-locks"
    encrypt        = true
  }
}