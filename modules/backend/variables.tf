# Variable default values derived from environment main terraform file
# ex: /terraform-aws-basic-infra/dev/main.tf

variable "bucket-name" {
  description = "Name of backend AWS S3 Bucket"
}
variable "dynamodb-table-name" {
  description = "Name of backend DynamoDB table"
}
variable "aws-region" {
  description = "Declare an AWS Region"
}