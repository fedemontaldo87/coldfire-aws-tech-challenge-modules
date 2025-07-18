resource "aws_s3_bucket" "images" {
  bucket        = "${var.prefix}-images"
  force_destroy = true
}

resource "aws_s3_bucket" "logs" {
  bucket        = "${var.prefix}-logs"
  force_destroy = true
}

# Simulated folders (S3 uses key prefixes)
resource "aws_s3_object" "images_archive" {
  bucket = aws_s3_bucket.images.id
  key    = "archive/"
  source = "/dev/null"
}

resource "aws_s3_object" "images_memes" {
  bucket = aws_s3_bucket.images.id
  key    = "memes/"
  source = "/dev/null"
}

resource "aws_s3_object" "logs_active" {
  bucket = aws_s3_bucket.logs.id
  key    = "active/"
  source = "/dev/null"
}

resource "aws_s3_object" "logs_inactive" {
  bucket = aws_s3_bucket.logs.id
  key    = "inactive/"
  source = "/dev/null"
}

# Lifecycle policy: move "memes/" to Glacier after 90 days
resource "aws_s3_bucket_lifecycle_configuration" "images_memes_policy" {
  bucket = aws_s3_bucket.images.id

  rule {
    id     = "memes-to-glacier"
    status = "Enabled"

    filter {
      prefix = "memes/"
    }

    transition {
      days          = 90
      storage_class = "GLACIER"
    }
  }
}

# logs/active → move to Glacier after 90 days
# logs/inactive → delete after 90 days
resource "aws_s3_bucket_lifecycle_configuration" "logs_policy" {
  bucket = aws_s3_bucket.logs.id

  rule {
    id     = "active-to-glacier"
    status = "Enabled"

    filter {
      prefix = "active/"
    }

    transition {
      days          = 90
      storage_class = "GLACIER"
    }
  }

  rule {
    id     = "inactive-delete"
    status = "Enabled"

    filter {
      prefix = "inactive/"
    }

    expiration {
      days = 90
    }
  }
}
