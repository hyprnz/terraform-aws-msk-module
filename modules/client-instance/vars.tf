variable "cluster_name" {
  type        = "string"
  description = "Name of the MSK Cluster to associate the Client Instance with"
}

variable "cluster_vpc_id" {
  type        = "string"
  description = "ID of the MSK Cluster VPC to associate the Client Instance with"
}

variable "ssh_location" {
  type        = "list"
  description = "SSH Location IP Address that enables access to the Client Instance"
}

variable "keypair_name" {
  type        = "string"
  description = "The name of the AWS Key Pair to use for SSH Access to Client Instance"
  default     = "MSK-Client"
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
