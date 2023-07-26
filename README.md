# AWS Lambda Terraform - Text Sentiment Analysis

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

Welcome to the AWS Lambda Terraform project for Text Sentiment Analysis! This project demonstrates how to deploy an AWS Lambda function using Terraform to perform text sentiment analysis.

## Introduction

This project provides an example implementation of a serverless text sentiment analysis application using AWS Lambda and Terraform. The Lambda function uses AWS Comprehend to analyze the sentiment of text data provided through an API Gateway endpoint.

## Architecture

The architecture of the project is as follows:

1. The Lambda function is responsible for handling incoming text data and passing it to the AWS Comprehend service for sentiment analysis.

2. The API Gateway serves as the entry point for incoming HTTP requests and triggers the Lambda function.

## Prerequisites

Before getting started, ensure you have the following:

- An AWS account with appropriate permissions to create Lambda functions and API Gateway resources.

- Terraform installed on your local machine. You can download Terraform from the official website: https://www.terraform.io/downloads.html

## Getting Started

1. Clone this repository to your local machine.

2. Navigate to the `terraform/` directory:

   ```
   cd terraform/
   ```

3. Create a file named `config.json` and set the desired AWS region:

   ```json
   {
     "region": "us-east-1"
   }
   ```

4. Initialize Terraform:

   ```
   terraform init
   ```

5. Deploy the Lambda function and API Gateway:

   ```
   terraform apply
   ```

6. After the deployment is complete, you will receive the API Gateway endpoint URL.

## Usage

To perform text sentiment analysis, make a POST request to the API Gateway endpoint with the text data in the request body. The Lambda function will analyze the sentiment and return the result in the response.

Example POST request using cURL:

```bash
curl -X POST -H "Content-Type: application/json" -d '{"text": "I love this product! It's amazing."}' <API_Gateway_URL>
```

## Cleanup

To remove the resources created by Terraform:

```
terraform destroy
```

## License

The code in this project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
