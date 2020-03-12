output "key_pair_id" {
  description = "the key pair ID"
  value       = "${module.keypair.id}"
}

output "public_key_filename" {
  description = "the Public Key filename"
  value       = "${module.keypair.public_key_filename}"
}
