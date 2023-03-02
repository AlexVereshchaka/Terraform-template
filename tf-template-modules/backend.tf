resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = "my-terraform-state-bucket"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Name = "my_s3_bucket"
  }
}

resource "aws_s3_bucket_policy" "my_s3_bucket_policy" {
  bucket = aws_s3_bucket.my_s3_bucket.id
}
policy = jsonencode({
  Version = "2012-10-17"
  Statement = [
    {
      Sid       = "DenyIncorrectEncryptionHeader"
      Effect    = "Deny"
      Principal = ""
      Action    = "s3:PutObject"
      Resource  = "${aws_s3_bucket.my_s3_bucket.arn}/"
      Condition = {
        StringNotEquals = { "s3:x-amz-server-side-encryption" = "AES256"
      } }
    }
  ]
})

