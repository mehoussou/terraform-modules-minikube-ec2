# AWS Remote Backend Resources

This Terraform module creates the required AWS resources to configure a Terraform module to make use of a remote backend using AWS S3 and AWS DynamoDB. AWS S3 stores the Terraform state files and AWS DynamoDB manages the Terraform locks. The following list displays the actions this module takes when applied:

1. Create bucket for storing backend Terraform state files
2. Encrypt remote state bucket with S3 SSE AES256
3. Enable remote backend versioning for roll backs
4. Create DynamoDB table to manage Terraform locks

Requirements: There are three variables that you **must** specify in order to provide a valid Terraform configuration:

1. AWS S3 Bucket name: `bucket-name`
2. AWS DynamoDB Table name: `dynamodb-table-name`
3. AWS Region: `aws-region`

Example usage:

```
module "backend" {
  source = "github.com/jakefurlong/terraform/modules/backend"

  bucket-name         = "example-dev-terraform-state"
  dynamodb-table-name = "example-dev-terraform-locks"
  aws-region          = "us-east-1"
}
```

You can create separate directories for each environment (i.e. dev, test, prod) and create a `main.tf` file in each directory. In that main file, you can create a `module` block (see example aove) and change the variables to match your cloud environment. Example: `bucket-name` could have the same naming convention across environments but you have to replace "dev" with "prod" in the production directory.
```
.
|--- README.md
|--- dev
|    |--- main.tf
|--- prod
|    |--- main.tf
```

To use the remote backend configuration for Terraform on AWS, declare a terraform backend block to utilize these new resources.
```
terraform {
  backend "s3" {
    bucket         = "example-dev-terraform-state"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "example-dev-terraform-locks"
  }
}
```