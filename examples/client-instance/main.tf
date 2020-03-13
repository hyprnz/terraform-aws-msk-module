locals {
  cluster_name = "MSK-Test-Cluster"
}

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

  cluster_name = "${local.cluster_name}"
}

module "client_instance" {
  source = "../../modules/client-instance"

  providers {
    aws = "aws"
  }

  cluster_name              = "${local.cluster_name}"
  cluster_vpc_id            = "${module.msk.vpc_id}"
  client_subnet_id          = "${element(module.msk.public_subnets, 0)}"
  msk_security_group_id     = "${module.msk.msk_security_group_id}"
  default_security_group_id = "${element(module.msk.security_group, 0)}"

  ssh_location = ["${var.ssh_location}"]
}
