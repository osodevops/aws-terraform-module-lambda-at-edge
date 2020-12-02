resource "aws_cloudwatch_log_group" "log_group" {
  name = "/aws/lambda/${var.function_name}"
  tags = var.common_tags
}
