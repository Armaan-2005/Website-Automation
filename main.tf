provider "aws" {
  region = "us-east-1"
  shared_credentials_files = [ "~/.aws/credentials" ]
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