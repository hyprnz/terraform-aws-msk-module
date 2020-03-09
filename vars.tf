variable "create_msk_cluster" {
  description = "Whether or not to create the MSK Cluster"
  default     = "true"
}

variable "use_custom_configuration" {
  description = "Use a custom configuration on each Kafka Broker"
  default     = "false"
}

variable "use_client_authentication" {
  description = "Use client authentication"
  default     = "false"
}

variable "cluster_name" {
  description = "Name of the MSK Cluster"
  type        = "string"
}

variable "kafka_version" {
  description = "Desired Kafka software version"
  type        = "string"
  default     = "2.2.1"
}

variable "num_of_broker_nodes" {
  description = "Desired total number of broker nodes in the kafka cluster. It must be a multiple of the number of specified client subnets"
  default     = 3
}

## Broker Node Information

variable "broker_node_instance_type" {
  description = "Instance type to use for the Kafka brokers"
  type        = "string"
  default     = "kafka.m5.large"
}

variable "broker_ebs_volume_size" {
  description = "Size in GiB of the EBS volume for the data drive on each broker node"
  default     = 2000
}

variable "client_subnets" {
  description = "A list of subnets to connect to in the client VPC"
  default     = []
}

variable "security_groups" {
  description = "A list of the security groups to associate with the elastic network interfaces to control who can communicate with the cluster"
  default     = []
}

variable "client_broker_encryption" {
  description = "Encryption setting for data in transit between clients and brokers. Valid values: TLS, TLS PLAINTEXT and PLAINTEXT"
  default     = "TLS"
}

variable "in_cluster_encryption" {
  description = "Whether data communication among broker nodes is encrypted"
  default     = true
}

variable "encryption_kms_key_arn" {
  description = "KMS key short ID or ARN to use for encrypting your data at rest. If no key is specified an AWS managed KMS key will be used for encrypting the data at rest"
  default     = ""
}

variable "certificate_authority_arns" {
  description = "List of ACM Certificate Authority Amazon Resource Names (ARNS)"
  default     = []
}

variable "enhanced_monitoring_level" {
  description = "Desired enhanced MSK CloudWatch monitoring level"
  type        = "string"
  default     = "DEFAULT"
}

## Configuration

variable "custom_configuration_name" {
  description = "Name of the MSK Custom configuration"
  default     = "Custom-MSK-Configuration-Example"
}

variable "custom_configuration_description" {
  description = "Description of the MSK Custom configuration"
  default     = "Custom MSK Configuration Example properties"
}

variable "msk_configuration_arn" {
  description = "ARN of the MSK Configuration to use in the cluster"
  default     = ""
}

variable "msk_configuration_revision" {
  description = "Revision of the MSK Configuration to use in the cluster"
  default     = 1
}

variable "server_properties" {
  description = "Contents of the server.properties file for Kafka broker"
  type        = "string"

  default = <<EOF
auto.create.topics.enable = false
default.replication.factor = 3
delete.topic.enable = true
min.insync.replicas = 2
num.io.threads = 8
num.network.threads = 5
num.partitions = 1
num.replica.fetchers = 2
socket.request.max.bytes = 104857600
unclean.leader.election.enable = true
EOF
}

## Dashboard
variable "create_dashboard" {
  description = "Whether or not to create the MSK Dashboard"
  default     = "false"
}

variable "custom_dashboard_template" {
  description = "Location for the custom MSK Dashboard template"
  default     = ""
}

## VPC

variable "create_vpc" {
  description = "Whether or not to create the MSK VPC"
  default     = "true"
}

variable "vpc_name" {
  description = "VPC name"
  default     = "MSK-VPC"
}

variable "vpc_cidr_block" {
  description = "VPC CIDR block"
  default     = "10.0.0.0/16"
}

variable "vpc_public_subnets" {
  description = "Public subnets for the VPC"
  default     = ["10.0.0.0/24"]
}

variable "vpc_private_subnets" {
  description = "Private subnets for the VPC"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}
