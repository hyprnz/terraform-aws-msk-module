locals {
  create_msk_cluster        = "${var.create_msk_cluster == "true" ? 1 : 0}"
  use_custom_configuration  = "${var.use_custom_configuration == "true" ? 1 : 0}"
  use_client_authentication = "${var.use_client_authentication == "true" ? 1 : 0}"
  internal_vpc              = "${var.create_vpc == "true" ? 1 : 0}"

  create_custom_configuration = "${local.use_custom_configuration * local.create_msk_cluster}"

  count_no_client_authentication = "${local.create_msk_cluster * (local.use_custom_configuration ? 0 : 1) * (local.use_client_authentication ? 0 : 1)}"
  count_custom_configuration     = "${local.create_custom_configuration * (local.use_client_authentication ? 0 : 1)}"
  count_client_authentication    = "${local.create_msk_cluster * (local.use_custom_configuration ? 0 : 1) * local.use_client_authentication}"
  count_msk_configuration        = "${length(var.msk_configuration_arn) > 0 ? 0 : local.create_custom_configuration}"

  cluster_name        = "${var.cluster_name}"
  kafka_version       = "${var.kafka_version}"
  num_of_broker_nodes = "${var.num_of_broker_nodes}"

  broker_node_instance_type = "${var.broker_node_instance_type}"
  broker_ebs_volume_size    = "${var.broker_ebs_volume_size}"

  client_subnets  = "${local.internal_vpc ? join(",", module.vpc.private_subnets) : join(",",var.client_subnets)}"
  security_groups = "${local.internal_vpc ? join(",", module.vpc.default_security_group) : join(",",var.security_groups)}"

  msk_configuration_arn      = "${length(var.msk_configuration_arn) > 0 ? var.msk_configuration_arn : element(concat(aws_msk_configuration.this.*.arn, list("")), 0)}"
  msk_configuration_revision = "${local.use_custom_configuration ? var.msk_configuration_revision : 1}"

  client_broker_encryption = "${var.client_broker_encryption}"
  in_cluster_encryption    = "${var.in_cluster_encryption}"
  encryption_kms_key_arn   = "${var.encryption_kms_key_arn}"

  certificate_authority_arns = "${var.certificate_authority_arns}"

  enhanced_monitoring_level = "${var.enhanced_monitoring_level}"
}

module "vpc" {
  source = "./modules/vpc"

  providers {
    aws = "aws"
  }

  create_vpc = "${var.create_vpc}"

  vpc_name        = "${var.vpc_name}"
  cidr_block      = "${var.vpc_cidr_block}"
  public_subnets  = "${var.vpc_public_subnets}"
  private_subnets = "${var.vpc_private_subnets}"
}

resource "aws_msk_cluster" "no_client_authentication" {
  count                  = "${local.count_no_client_authentication}"
  cluster_name           = "${local.cluster_name}"
  kafka_version          = "${local.kafka_version}"
  number_of_broker_nodes = "${local.num_of_broker_nodes}"

  broker_node_group_info {
    instance_type   = "${local.broker_node_instance_type}"
    ebs_volume_size = "${local.broker_ebs_volume_size}"
    client_subnets  = ["${split(",",local.client_subnets)}"]
    security_groups = ["${split(",",local.security_groups)}", "${aws_security_group.msk_cluster.id}"]
  }

  encryption_info {
    encryption_in_transit = {
      client_broker = "${local.client_broker_encryption}"
      in_cluster    = "${local.in_cluster_encryption}"
    }

    encryption_at_rest_kms_key_arn = "${local.encryption_kms_key_arn}"
  }

  enhanced_monitoring = "${local.enhanced_monitoring_level}"

  tags = {
    Name = "${local.cluster_name}"
  }
}

resource "aws_msk_cluster" "custom_configuration" {
  count                  = "${local.count_custom_configuration}"
  cluster_name           = "${local.cluster_name}"
  kafka_version          = "${local.kafka_version}"
  number_of_broker_nodes = "${local.num_of_broker_nodes}"

  broker_node_group_info {
    instance_type   = "${local.broker_node_instance_type}"
    ebs_volume_size = "${local.broker_ebs_volume_size}"
    client_subnets  = ["${split(",",local.client_subnets)}"]
    security_groups = ["${split(",",local.security_groups)}", "${aws_security_group.msk_cluster.id}"]
  }

  configuration_info {
    arn      = "${local.msk_configuration_arn}"
    revision = "${local.msk_configuration_revision}"
  }

  encryption_info {
    encryption_in_transit = {
      client_broker = "${local.client_broker_encryption}"
      in_cluster    = "${local.in_cluster_encryption}"
    }

    encryption_at_rest_kms_key_arn = "${local.encryption_kms_key_arn}"
  }

  enhanced_monitoring = "${local.enhanced_monitoring_level}"

  tags = {
    Name = "${local.cluster_name}"
  }
}

resource "aws_msk_cluster" "client_authentication" {
  count                  = "${local.count_client_authentication}"
  cluster_name           = "${local.cluster_name}"
  kafka_version          = "${local.kafka_version}"
  number_of_broker_nodes = "${local.num_of_broker_nodes}"

  broker_node_group_info {
    instance_type   = "${local.broker_node_instance_type}"
    ebs_volume_size = "${local.broker_ebs_volume_size}"
    client_subnets  = ["${split(",",local.client_subnets)}"]
    security_groups = ["${split(",",local.security_groups)}", "${aws_security_group.msk_cluster.id}"]
  }

  client_authentication {
    tls {
      certificate_authority_arns = "${local.certificate_authority_arns}"
    }
  }

  encryption_info {
    encryption_in_transit = {
      client_broker = "${local.client_broker_encryption}"
      in_cluster    = "${local.in_cluster_encryption}"
    }

    encryption_at_rest_kms_key_arn = "${local.encryption_kms_key_arn}"
  }

  enhanced_monitoring = "${local.enhanced_monitoring_level}"

  tags = {
    Name = "${local.cluster_name}"
  }
}

resource "aws_msk_configuration" "this" {
  count          = "${local.count_msk_configuration}"
  kafka_versions = ["${local.kafka_version}"]

  name        = "${var.custom_configuration_name}"
  description = "${var.custom_configuration_description}"

  server_properties = <<PROPERTIES
${var.server_properties}
PROPERTIES
}
