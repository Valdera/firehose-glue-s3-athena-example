# AWS Analytics Pipeline with Terraform

A complete AWS analytics pipeline built with Terraform that demonstrates near real-time data streaming and processing using AWS services.

Full Medium Blog:
https://medium.com/@fauzanvaldera/building-a-serverless-data-pipeline-using-aws-firehose-s3-glue-data-catalog-and-athena-a43495965baa

## Architecture

This project creates a serverless analytics pipeline that ingests user events, stores them in S3, and makes them queryable through AWS Glue Data Catalog.

### Components

- **S3 Bucket**: Stores analytics data in Parquet format with automatic partitioning
- **Kinesis Data Firehose**: Streams real-time data from applications to S3
- **AWS Glue Data Catalog**: Provides metadata and schema information for analytics
- **Python Client**: Sample application to send events to the pipeline

## Prerequisites

- AWS CLI configured with appropriate permissions
- Terraform >= 1.0
- Python 3.7+
- boto3 library for Python client

## Getting Started

### 1. Configure AWS Credentials

```bash
aws configure
```

### 2. Deploy Infrastructure

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

### 3. Test the Pipeline

```bash
python main.py
```

## Project Structure

```
terraform_guide/
├── terraform/
│   ├── 00-terraform.tf       # Provider and backend configuration
│   ├── 01-data.tf           # Data sources for account/region info
│   ├── 02-s3.tf             # S3 bucket with security configurations
│   ├── 03-glue-data-catalog.tf # Glue database and table definitions
│   └── 04-firehose.tf       # Kinesis Firehose and IAM roles
├── main.py                  # Python client for sending events
└── README.md               # This file
```

## Configuration

### Backend State

Update the S3 backend configuration in `terraform/00-terraform.tf`:

```hcl
terraform {
  backend "s3" {
    bucket = "your-terraform-state-bucket"
    key    = "analytics/terraform.tfstate"
    region = "your-region"
  }
}
```

## Data Schema

Events sent to the pipeline should follow this schema:

```json
{
  "user_id": "string",
  "event_type": "string",
  "page_url": "string",
  "timestamp": "YYYY-MM-DD HH:MM:SS",
  "device_type": "string",
  "browser": "string",
  "country": "string"
}
```

## Data Storage

Data is automatically partitioned by date in S3:

```
s3://analytics-data-{account-id}/user-events/
├── year=2024/
│   └── month=01/
│       └── day=15/
│           └── firehose_output.parquet
```
