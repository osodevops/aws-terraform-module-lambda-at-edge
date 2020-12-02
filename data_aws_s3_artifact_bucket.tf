data "aws_s3_bucket" "artifact_bucket" {
  bucket = var.s3_artifact_bucket_name
  provider = aws.cloudfront
}