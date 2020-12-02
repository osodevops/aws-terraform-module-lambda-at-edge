variable "common_tags" {
  type        = map(string)
  description = "Implements the common tags."
}

variable "config_file_name" {
  type = string
  description = "The name of the file var.plaintext_params will be written to as json."
  default     = "config.json"
}

variable "description" {
  description = "Description of what the Lambda@Edge Function is cooking."
}

variable "environment" {
  description = "Environment in which the function is going to run."
}

variable "file_globs" {
  type        = list(string)
  description = "list of files or globs that you want included from the lambda_code_source_dir"
  default     = ["index.js", "node_modules/**", "yarn.lock", "package.json"]
}

variable "function_name" {
  type = string
  description = "Name of the Lambda@Edge Function."
}

variable "lambda_code_source_dir" {
  type = string
  description = "An absolute path to the directory containing the code to upload to lambda"
}

variable "lambda_handler" {
  type = string
  description = "The path to the main method that should handle the incoming requests."
  default     = "index.handler"
}

variable "lambda_runtime" {
  type = string
  description = "The runtime of the lambda function."
  default     = "nodejs10.x"

}

variable "plaintext_params" {
  type        = map(string)
  default     = {}
  description = <<EOF
  Lambda@Edge does not support env vars, so it is a common pattern to exchange Env vars for values read from a config file.
  So instead of using env vars like:
  `const someEnvValue = process.env.SOME_ENV`
  you would have lookups from a config file:
  ```
  const config = JSON.parse(readFileSync('./config.json'))
  const someConfigValue = config.SomeKey
  ```

  Compared to var.ssm_params, you should use this variable when you have non-secret things that you want very quick access
  to during the execution of your lambda function.
  EOF
}

variable "s3_artifact_bucket_name" {
  type = string
  description = "Name of the S3 bucket to upload versioned artifacts to."
}