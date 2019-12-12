output "id" {
  description = "The ID of the VPC created"
  value       = "${element(concat(aws_vpc.this.*.id, list("")), 0)}"
  depends_on  = ["${aws_vpc.this}"]
}

output "public_subnets" {
  description = "The public subnets in the VPC created"
  value       = ["${aws_subnet.public.*.id}"]
}

output "private_subnets" {
  description = "The private subnets in the VPC created"
  value       = ["${aws_subnet.private.*.id}"]
}

output "default_security_group" {
  description = "The default security group for the VPC"
  value       = "${data.aws_security_group.default.*.id}"
}
