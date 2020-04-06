module "msk" {
  source = "../../"

  providers {
    aws = "aws"
  }

  # MSK Feature Toggles
  create_vpc                = "false"
  create_msk_cluster        = "true"
  use_custom_configuration  = "false"
  use_client_authentication = "false"

  cluster_name = "MSK-Test-Cluster"

  vpc_id          = "${module.vpc.id}"
  client_subnets  = ["${module.vpc.private_subnets}"]
  security_groups = ["${module.vpc.default_security_group}"]
}
