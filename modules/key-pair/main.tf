locals {
  public_key_filename = "${format(
    "%s%s%s",
    var.ssh_public_key_path,
    var.key_name,
    var.public_key_extension
  )}"
}

resource "aws_key_pair" "imported" {
  key_name   = "${var.key_name}"
  public_key = "${file("${local.public_key_filename}")}"
}
