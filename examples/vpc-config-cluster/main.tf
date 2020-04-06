module "msk" {
  source = "../../"

  providers {
    aws = "aws"
  }

  # MSK Feature Toggles
  create_vpc                = "true"
  create_msk_cluster        = "true"
  use_custom_configuration  = "false"
  use_client_authentication = "false"

  cluster_name = "MSK-Test-Cluster"

  # VPC Configuration
  vpc_name            = "MSK-VPC-Test"
  vpc_cidr_block      = "10.1.0.0/16"
  vpc_public_subnets  = ["10.1.0.0/24"]
  vpc_private_subnets = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
}
