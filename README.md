```
# AWS Lambda Terraform - Text Sentiment Analysis

## Description

This is a serverless project that demonstrates text sentiment analysis using AWS Lambda and AWS Comprehend. The application provides an API endpoint that accepts text input from users and uses AWS Comprehend's natural language processing capabilities to determine the sentiment (positive, neutral, or negative) of the provided text.

## Table of Contents

- [Description](#description)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
  - [Terraform Configuration](#terraform-configuration)
- [Usage](#usage)
- [Cleanup](#cleanup)
- [Contributing](#contributing)
- [License](#license)

## Prerequisites

To deploy and use this project, you'll need the following tools installed on your machine:

- Terraform
- AWS CLI with configured credentials

## Getting Started

Follow the steps below to set up the project and deploy the Text Sentiment Analysis application.

### Terraform Configuration

1. Clone this repository:
   ```bash
   git clone <your-github-repo-url>
   cd aws_lambda_terraform_text_sentiment
   ```

2. Create a `config.json` file in the root of the `terraform/` directory with the following content:

   ```json
   {
     "aws_region": "us-east-1"
   }
   ```

   Replace `"us-east-1"` with your desired AWS region for deployment.

3. Navigate to the `terraform/` directory:
   ```bash
   cd terraform/
   ```

4. Initialize Terraform:
   ```bash
   terraform init
   ```

5. Deploy the infrastructure resources using Terraform:
   ```bash
   terraform apply
   ```

   **Note:** Terraform will prompt you to confirm the changes. Type `yes` to proceed.

After the Terraform deployment is complete, the API Gateway endpoint URL for the Text Sentiment Analysis application will be displayed in the Terraform output.

## Usage

Once the project is deployed, you can interact with the Text Sentiment Analysis API:

- Send a POST request to the API Gateway endpoint URL with the following payload:

  ```json
  {
    "text": "Your text for sentiment analysis goes here."
  }
  ```

  Replace `"Your text for sentiment analysis goes here."` with the text you want to analyze.

- The API will return the sentiment analysis result (positive, neutral, or negative) based on the provided text.

## Cleanup

To remove the resources and clean up the environment, follow these steps:

1. Navigate to the `terraform/` directory:
   ```bash
   cd terraform/
   ```

2. Destroy the created infrastructure:
   ```bash
   terraform destroy
   ```

   **Note:** Terraform will prompt you to confirm the destruction. Type `yes` to proceed.

## Contributing

Contributions to this project are welcome. If you find any issues or want to add new features, feel free to submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).
```