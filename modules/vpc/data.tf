data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_security_group" "default" {
  count  = "${local.create_vpc ? 1 : 0}"
  name   = "default"
  vpc_id = "${aws_vpc.this.id}"
}
