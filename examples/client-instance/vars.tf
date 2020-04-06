variable "my_region" {
  description = "AWS Region where resources will be provisioned for the example"
  default     = "ap-southeast-2"
}

variable "ssh_location" {
  description = "CIDR Block for the IP Addresses able to access the Client Instance"
}
