output "name" {
  description = "The key pair name"
  value       = "${aws_key_pair.imported.key_name}"
}

output "id" {
  description = "The key pair ID"
  value       = "${aws_key_pair.imported.key_pair_id}"
}

output "fingerprint" {
  description = "The MD5 public key fingerprint as specified in section 4 of RFC 476"
  value       = "${aws_key_pair.imported.fingerprint}"
}

output "public_key_filename" {
  description = "Public Key filename"
  value       = "${local.public_key_filename}"
}
