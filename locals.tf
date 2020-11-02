locals {
  create_msk_cluster        = var.create_msk_cluster
  use_custom_configuration  = var.use_custom_configuration
  use_client_authentication = var.use_client_authentication
  internal_vpc              = var.create_vpc && local.create_msk_cluster

  create_custom_configuration  = local.use_custom_configuration && local.create_msk_cluster
  create_client_authentication = local.use_client_authentication && local.create_msk_cluster

  count_custom_configuration  = local.create_custom_configuration ? 1 : 0
  count_client_authentication = local.create_client_authentication ? 1 : 0
  count_msk_configuration     = (length(var.msk_configuration_arn) > 0 ? 0 : 1) * (local.create_custom_configuration ? 1 : 0)

  cluster_name        = var.cluster_name
  kafka_version       = var.kafka_version
  num_of_broker_nodes = var.num_of_broker_nodes

  broker_node_instance_type = var.broker_node_instance_type
  broker_ebs_volume_size    = var.broker_ebs_volume_size

  client_subnets  = local.internal_vpc ? module.vpc.private_subnets : var.client_subnets
  security_groups = local.internal_vpc ? module.vpc.default_security_group : var.security_groups

  msk_configuration_arn      = length(var.msk_configuration_arn) > 0 ? var.msk_configuration_arn : element(concat(aws_msk_configuration.this[*].arn, list("")), 0)
  msk_configuration_revision = local.use_custom_configuration ? var.msk_configuration_revision : 1

  client_broker_encryption = var.client_broker_encryption
  in_cluster_encryption    = var.in_cluster_encryption
  encryption_kms_key_arn   = var.encryption_kms_key_arn

  certificate_authority_arns = var.certificate_authority_arns

  enhanced_monitoring_level = var.enhanced_monitoring_level

  vpc_id = var.create_vpc == true ? module.vpc.id : var.vpc_id

  create_dashboard          = var.create_dashboard == true ? 1 : 0
  create_diskspace_cw_alarm = var.create_diskspace_cw_alarm == true ? 1 : 0
  create_cw_alarm           = local.create_dashboard * local.create_diskspace_cw_alarm

  custom_dashboard = var.custom_dashboard_template

  dashboard_template = length(local.custom_dashboard) > 0 ? local.custom_dashboard : "${path.module}/templates/dashboard-default.tpl"

  jmx_exporter_enabled  = var.jmx_exporter_enabled
  node_exporter_enabled = var.node_exporter_enabled

  s3_logging_enabled = var.s3_logging_enabled
  s3_logging_bucket  = var.s3_logging_bucket
  s3_logging_prefix  = var.s3_logging_prefix
}
