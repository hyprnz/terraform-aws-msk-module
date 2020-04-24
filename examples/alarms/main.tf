locals {
  cluster_name = "MSK-Test-Cluster"
}

module "msk" {
  source = "../../"

  providers = {
    aws = aws
  }

  # MSK Feature Toggles
  create_vpc                = true
  create_msk_cluster        = true
  create_dashboard          = true
  create_diskspace_cw_alarm = true
  use_custom_configuration  = false
  use_client_authentication = false

  tags             = merge(map("Environment", "Test"), map("Team", "Infra"))
  msk_cluster_tags = map("Version", "2.2.1")
  vpc_tags         = map("Resource Owner", local.cluster_name)
  monitoring_tags  = map("Monitoring Target", local.cluster_name)

  cluster_name = local.cluster_name
}
