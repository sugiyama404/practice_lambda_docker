resource "aws_lambda_function" "main" {
  function_name = var.lambda_function_name
  package_type  = "Image"
  image_uri     = "${var.lambda_repository_url}:latest"
  description   = "lambda_function"
  role          = var.lambda_iam_role
  publish       = true
  memory_size   = 128
  timeout       = 30
  depends_on    = [aws_cloudwatch_log_group.lambda]

  tags = {
    Name = "${var.app_name}-lamdba"
  }
}
