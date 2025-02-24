/**
 * Upload the build artifact zip file to S3 using aws_s3_object.
 *
 */
resource "aws_s3_object" "artifact" {
  provider = aws.cloudfront
  bucket   = data.aws_s3_bucket.artifact_bucket.id
  key      = "${var.function_name}.zip"
  source   = data.archive_file.zip_file_for_lambda.output_path
  etag     = filemd5(data.archive_file.zip_file_for_lambda.output_path)
  tags     = var.common_tags
}
