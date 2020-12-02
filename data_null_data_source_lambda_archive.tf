data "archive_file" "zip_file_for_lambda" {
  type        = "zip"
  output_path = "lambda_code.zip"

  dynamic source {
    for_each = distinct(flatten([
    for blob in var.file_globs :
    fileset(var.lambda_code_source_dir, blob)
    ]))
    content {
      content = try(
      file("${var.lambda_code_source_dir}/${source.value}"),
      filebase64("${var.lambda_code_source_dir}/${source.value}"),
      )
      filename = source.value
    }
  }

  # Optionally write a `config.json` file if any plaintext params were given
  dynamic source {
    for_each = length(keys(var.plaintext_params)) > 0 ? ["true"] : []
    content {
      content  = jsonencode(var.plaintext_params)
      filename = var.config_file_name
    }
  }
}