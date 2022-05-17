# Create bucket for backend k8s state files
resource "aws_s3_bucket" "remote_state_bucket" {
  bucket = var.bucket-name
  tags = {
    Name        = var.bucket-name
    Environment = "terraform"
  }
}

# Encrypt remote state bucket with S3 SSE AES256
resource "aws_s3_bucket_server_side_encryption_configuration" "remote_state_bucket_encryption" {
  bucket = aws_s3_bucket.remote_state_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Enable remote backend versioning for roll backs
resource "aws_s3_bucket_versioning" "remote_state_bucket_versioning" {
  bucket = aws_s3_bucket.remote_state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Create DynamoDB table for Terraform network locks
resource "aws_dynamodb_table" "remote_locks" {
  name         = var.dynamodb-table-name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}