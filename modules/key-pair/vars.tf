variable "key_name" {
  type        = "string"
  description = "Name for the AWS Key Pair"
}

variable "ssh_public_key_path" {
  type        = "string"
  description = "Path to the SSH public key directory"
}

variable "public_key_extension" {
  type        = "string"
  default     = ".pub"
  description = "Public key extension"
}
