provider "aws" {
  region = "us-east-1"
  shared_credentials_files = [ "~/.aws/credentials" ]
}
resource "aws_s3_bucket" "name" {
    bucket = "backend-for-webpage-automation"
    force_destroy = true
}