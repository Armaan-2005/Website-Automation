provider "aws" {
  region = "us-east-1"
  shared_credentials_files = [ "~/.aws/credentials" ]
}
terraform {
  backend "s3" {
    bucket = "backend-for-webpage-automation"
    key = "webpage/terraform.tfstate"
    region = "us-east-1"
  }
}
module "vpc" {
  source = "./modules/vpc"
}
module "ec2" {
  source = "./modules/ec2"
  subnet = module.vpc.pub_sub_id
  key = module.vpc.key_name
  vpc-sg = [module.vpc.sg]
}
module "cloudwatch" {
  source = "./modules/cloudwatch"
  instance_id = module.ec2.instance_id
  alert_email = var.alert_email
}