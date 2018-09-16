# provider "aws" {
#   shared_credentials_file = "~/.aws/credentials"
#   profile = "PROFILE"
#   region = "${var.aws_region}"
# }
# terraform {
#   backend "s3" {
#     bucket = "BUCKET_NAME"
#     key = "infrastructure/wordpress"
#     region = "us-east-1"
#     shared_credentials_file = "~/.aws/credentials"
#     profile = "PROFILE"
#   }
# }
