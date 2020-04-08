variable "cluster_name" {
  type        = "string"
  description = "Name of the MSK Cluster to associate the Client Instance with"
}

variable "cluster_vpc_id" {
  type        = "string"
  description = "ID of the MSK Cluster VPC to associate the Client Instance with"
}

variable "client_instance_type" {
  type        = "string"
  description = "The EC2 Client Instance Type"
  default     = "m5.large"
}

variable "client_subnet_id" {
  type        = "string"
  description = "The Public Subnet to launch the Client Instance in"
}

variable "msk_security_group_id" {
  type        = "string"
  description = "The MSK Cluster Security group to add Security Rules to"
}

variable "default_security_group_id" {
  type        = "string"
  description = "The default MSK Cluster Security group"
}

variable "cwagent_log_group_name" {
  type        = "string"
  description = "The name of the CloudWatch log group where the instance logs are sent."
}

variable "cwagent_log_group_retention_period" {
  description = "The CloudWatch Log Group rentention period in days. Defaults to `30` days"
  default     = 30
}
