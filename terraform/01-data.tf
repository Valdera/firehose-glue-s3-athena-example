data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_kms_key" "s3" {
  key_id = "alias/aws/s3"
}
