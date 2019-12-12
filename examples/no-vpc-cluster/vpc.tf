module "vpc" {
  source = "../../modules/vpc"

  providers {
    aws = "aws"
  }

  create_vpc = "true"

  vpc_name        = "External-MSK-VPC"
  cidr_block      = "10.0.0.0/16"
  public_subnets  = ["10.0.0.0/24"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}
