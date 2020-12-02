# Create the Lambda function. Each new apply will publish a new version.
resource "aws_lambda_function" "lambda" {
  function_name           = var.function_name
  description             = var.description
  provider                = aws.cloudfront
  # Find the file from S3
  s3_bucket         = data.aws_s3_bucket.artifact_bucket.id
  s3_key            = aws_s3_bucket_object.artifact.id
  s3_object_version = aws_s3_bucket_object.artifact.version_id

  publish = true
  handler = var.lambda_handler
  runtime = var.lambda_runtime
  role    = aws_iam_role.edge_lambda_role.arn

  lifecycle {
    ignore_changes = [
      last_modified,
      filename
    ]
  }

  tags = merge(var.common_tags, {
    "Name" = "${upper(var.environment)}-LOG-COLLECTOR-LAMBDA"
  },
  )
}