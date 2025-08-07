terraform {
  backend "s3" {
    bucket                 = "{terraform bucket name}"
    dynamodb_table         = "{terraform dynamodb table name}"
    key                    = "ap-southeast-1/sample/analytics/terraform.tfstate"
    region                 = "ap-southeast-1"
    encrypt                = true
    skip_region_validation = true
  }
}

provider "aws" {
  region = "ap-southeast-1"
}
