locals {
  vpc_id = "${var.create_vpc == "true" ? module.vpc.id : var.vpc_id}"
}

resource "aws_security_group" "msk_cluster" {
  name        = "${local.cluster_name}"
  description = "MSK Security Group"
  vpc_id      = "${local.vpc_id}"

  tags = {
    Name = "${local.cluster_name}"
  }
}
