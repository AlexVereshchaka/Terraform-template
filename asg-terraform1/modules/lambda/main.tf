resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_execution_policy" {
  name        = "lambda_execution_policy"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeInstanceStatus",
          "ec2:ModifyInstanceAttribute"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_execution_policy_attachment" {
  policy_arn = aws_iam_policy.lambda_execution_policy.arn
  role       = aws_iam_role.lambda_execution_role.name
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "./modules/lambda/lambda-lunction"
  output_path = "./modules/lambda/lambda-lunction/lambda_function.zip"
}

resource "aws_lambda_function" "server_redirect_lambda" {
  filename      = data.archive_file.lambda_zip.output_path
  function_name = "server_redirect_lambda"
  role          = aws_iam_role.lambda_execution_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"

  /* environment {
    variables = {
      source_server_id = var.source_server_id
      target_server_id = var.target_server_id
    }
  } */
}

resource "aws_cloudwatch_event_rule" "lambda_trigger" {
  name                = "lambda_trigger"
  description         = "Trigger lambda function to redirect traffic when CPU utilization is low"
  schedule_expression = "rate(1 minute)"
}

resource "aws_cloudwatch_event_target" "lambda_trigger_target" {
  rule      = aws_cloudwatch_event_rule.lambda_trigger.name
  arn       = aws_lambda_function.server_redirect_lambda.arn
  target_id = "lambda_trigger_target"
}

