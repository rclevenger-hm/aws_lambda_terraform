output "api_endpoint_url" {
  description = "API Gateway Endpoint URL for text sentiment analysis"
  value       = aws_api_gateway_deployment.text_sentiment_api_deployment.invoke_url
}
