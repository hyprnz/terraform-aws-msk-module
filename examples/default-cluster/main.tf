module "msk" {
  source = "../../"

  providers {
    aws = "aws"
  }

  # MSK Feature Toggles
  create_vpc                = "true"
  create_msk_cluster        = "true"
  #create_dashboard          = "true"
  use_custom_configuration  = "false"
  use_client_authentication = "false"

  cluster_name = "MSK-Test-Cluster"
}
