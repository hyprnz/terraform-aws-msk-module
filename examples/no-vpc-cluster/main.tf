
# The call to the VPC submodule is provides as a convienience if an exisitng VPC does not exist.data
# Maybe commented out if not used
module "example_no_vpc" {
  source = "../../modules/vpc"

  providers = {
    aws = aws
  }

  create_vpc = "true"

  vpc_name        = "External-MSK-VPC"
  cidr_block      = "10.0.0.0/16"
  public_subnets  = ["10.0.0.0/24"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}


module "msk" {
  source = "../../"

  providers = {
    aws = aws
  }

  # MSK Feature Toggles
  create_vpc                = false
  create_msk_cluster        = true
  use_custom_configuration  = false
  use_client_authentication = false

  cluster_name = "MSK-Test-Cluster"

  vpc_id          =  module.example_no_vpc.id
  client_subnets  =  module.example_no_vpc.private_subnets
  security_groups =  module.example_no_vpc.default_security_group
}
