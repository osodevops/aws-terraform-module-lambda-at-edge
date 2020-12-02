resource "aws_iam_role" "edge_lambda_role" {
  name               = "${upper(var.environment)}-${upper(var.function_name)}-LAMBDA-ROLE"
  description        = "Allows Lambda function to execute log collection."
  assume_role_policy = data.aws_iam_policy_document.lambda_config_trust.json
}

/**
 * Policy to allow AWS to access this lambda function.
 */
data "aws_iam_policy_document" "lambda_config_trust" {
  statement {
    sid    = "AllowAwsToAssumeRole"
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"

      identifiers = [
        "lambda.amazonaws.com",
        "edgelambda.amazonaws.com",
      ]
    }
  }
}

data "aws_iam_policy_document" "lambda_logs_policy_doc" {
  statement {
    effect    = "Allow"
    resources = ["*"]
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:CreateLogGroup",
    ]
  }
}

resource "aws_iam_role_policy" "logs_role_policy" {
  name   = "${upper(var.environment)}-${upper(var.function_name)}-AT-EDGE"
  role   = aws_iam_role.edge_lambda_role.id
  policy = data.aws_iam_policy_document.lambda_logs_policy_doc.json
}