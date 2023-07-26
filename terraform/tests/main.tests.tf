provider "aws" {
  region = "us-east-1"  # Replace with your desired default region for testing
}

data "aws_caller_identity" "current" {}

test "aws_region_is_us_east_1" {
  condition      = provider.aws.region == "us-east-1"
  success_message = "Region is set correctly to us-east-1."
  failure_message = "Region is not set to us-east-1."
}

test "provider_version_valid" {
  condition      = can(data.aws_caller_identity.current.account_id)
  success_message = "Provider version is valid."
  failure_message = "Provider version is not valid."
}

test "lambda_function_exists" {
  # Ensure that the Lambda function resource exists
  condition      = can(aws_lambda_function.text_sentiment_lambda.arn)
  success_message = "Lambda function resource exists."
  failure_message = "Lambda function resource does not exist."
}

test "api_gateway_exists" {
  # Ensure that the API Gateway resource exists
  condition      = can(aws_api_gateway_rest_api.text_sentiment_api.id)
  success_message = "API Gateway resource exists."
  failure_message = "API Gateway resource does not exist."
}
