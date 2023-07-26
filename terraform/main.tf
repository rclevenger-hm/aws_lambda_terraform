locals {
  region = try(file("${path.module}/config.json"), null) != null ? jsondecode(file("${path.module}/config.json")).region : "us-east-1"
}

provider "aws" {
  region = local.region
}

# IAM Role for Lambda
resource "aws_iam_role" "lambda_role" {
  name = "lambda-text-sentiment-role"

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

# IAM Policy for Lambda
resource "aws_iam_policy" "lambda_policy" {
  name        = "lambda-text-sentiment-policy"
  description = "Policy for the Lambda function to access Comprehend"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [
          "comprehend:DetectSentiment",
          "comprehend:BatchDetectSentiment"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# Attach the policy to the Lambda role
resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  policy_arn = aws_iam_policy.lambda_policy.arn
  role       = aws_iam_role.lambda_role.name
}

# Lambda Function
resource "aws_lambda_function" "text_sentiment_lambda" {
  function_name = "text-sentiment-analysis-lambda"
  role          = aws_iam_role.lambda_role.arn
  runtime       = "nodejs14.x"
  handler       = "handler.analyzeSentiment"
  filename      = "../handler.js"

  tags = {
    app_name     = "TextSentimentApp"
    region       = local.region
    service_type = "lambda"
  }
}

# API Gateway
resource "aws_api_gateway_rest_api" "text_sentiment_api" {
  name        = "text-sentiment-analysis-api"
  description = "API Gateway for text sentiment analysis"

  tags = {
    app_name     = "TextSentimentApp"
    region       = local.region
    service_type = "api_gateway"
  }
}

resource "aws_api_gateway_resource" "text_sentiment_api_resource" {
  rest_api_id = aws_api_gateway_rest_api.text_sentiment_api.id
  parent_id   = aws_api_gateway_rest_api.text_sentiment_api.root_resource_id
  path_part   = "analyze-sentiment"
}

resource "aws_api_gateway_method" "text_sentiment_api_method" {
  rest_api_id   = aws_api_gateway_rest_api.text_sentiment_api.id
  resource_id   = aws_api_gateway_resource.text_sentiment_api_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "text_sentiment_api_integration" {
  rest_api_id             = aws_api_gateway_rest_api.text_sentiment_api.id
  resource_id             = aws_api_gateway_resource.text_sentiment_api_resource.id
  http_method             = aws_api_gateway_method.text_sentiment_api_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.text_sentiment_lambda.invoke_arn
}

resource "aws_api_gateway_method_response" "text_sentiment_api_method_response" {
  rest_api_id = aws_api_gateway_rest_api.text_sentiment_api.id
  resource_id = aws_api_gateway_resource.text_sentiment_api_resource.id
  http_method = aws_api_gateway_method.text_sentiment_api_method.http_method

  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "text_sentiment_api_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.text_sentiment_api.id
  resource_id = aws_api_gateway_resource.text_sentiment_api_resource.id
  http_method = aws_api_gateway_method.text_sentiment_api_method.http_method

  response_templates = {
    "application/json" = ""
  }
}
