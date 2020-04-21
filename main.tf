module "vpc" {
  source = "./modules/vpc"

  providers = {
    aws = aws
  }

  create_vpc = local.internal_vpc

  vpc_name        = var.vpc_name
  cidr_block      = var.vpc_cidr_block
  public_subnets  = var.vpc_public_subnets
  private_subnets = var.vpc_private_subnets
}

resource "aws_msk_cluster" "this" {
  count = local.create_msk_cluster ? 1 : 0

  cluster_name           = local.cluster_name
  kafka_version          = local.kafka_version
  number_of_broker_nodes = local.num_of_broker_nodes

  broker_node_group_info {
    instance_type   = local.broker_node_instance_type
    ebs_volume_size = local.broker_ebs_volume_size
    client_subnets  = local.client_subnets
    security_groups = concat(local.security_groups, list(aws_security_group.msk_cluster.id))
  }

  encryption_info {
    encryption_in_transit  {
      client_broker = local.client_broker_encryption
      in_cluster    = local.in_cluster_encryption
    }

    encryption_at_rest_kms_key_arn = local.encryption_kms_key_arn
  }

  enhanced_monitoring =  local.enhanced_monitoring_level


  dynamic "configuration_info" {
    for_each = local.count_custom_configuration == 1 ? ["enabled"] : []
    content {
      arn      = local.msk_configuration_arn
      revision = local.msk_configuration_revision
    }
  }


  dynamic "client_authentication" {
    for_each = local.count_client_authentication == 1 ? ["enabled"] : []
    content {
      tls {
        certificate_authority_arns = local.certificate_authority_arns
      }
    }
  }

  tags = {
    Name = local.cluster_name
  }
}

resource "aws_msk_configuration" "this" {
  count          = local.count_msk_configuration
  kafka_versions = [local.kafka_version]

  name        = var.custom_configuration_name
  description = var.custom_configuration_description

  server_properties = <<PROPERTIES
  ${var.server_properties}
PROPERTIES
}
