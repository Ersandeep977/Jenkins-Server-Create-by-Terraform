resource "aws_s3_bucket" "onebucket" {
  bucket              = "sandeep-kumar-patel-testing-s3-for-terraform"
  acl                 = "private"
  force_destroy       = true
  object_lock_enabled = true
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  versioning {
    enabled = true
  }
  tags = {
    Name        = "Sandeep_bucket"
    Environment = "Dev"
  }
}