resource "aws_s3_bucket" "grocery_s3" {
  bucket = var.bucket_name
  force_destroy = false
}



resource "aws_s3_bucket_versioning" "grocery_s3_versioning" {
  bucket = aws_s3_bucket.grocery_s3.id
  versioning_configuration {
    status = var.versioning_status
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "grocery_s3_lifecycle" {
  bucket = aws_s3_bucket.grocery_s3.id

  rule {
    id     = "expire-old-avatars"
    status = var.lifecycle_status

    filter {
      prefix = var.avatar_prefix
    }

    expiration {
      days = var.expiration_days
    }
  }
}

resource "aws_s3_bucket_public_access_block" "grocery_s3_block" {
  bucket = aws_s3_bucket.grocery_s3.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = false  # Change to false
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_policy" "grocery_s3_policy" {
  bucket = aws_s3_bucket.grocery_s3.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*"
        Action = ["s3:GetObject", "s3:PutObject"]
         "Resource":  "arn:aws:s3:::${aws_s3_bucket.grocery_s3.bucket}/avatars/*"

      }
    ]
  })
}


resource "aws_s3_object" "avatar_image" {
  bucket = aws_s3_bucket.grocery_s3.id
  key    = "${var.avatar_prefix}${var.avatar_filename}"
  source = var.avatar_path
}

