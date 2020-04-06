## Security Groups

resource "aws_security_group" "kafka_client_instance" {
  name        = "Kafka-Client-Instance"
  description = "Enable SSH access via port 22"
  vpc_id      = "${var.cluster_vpc_id}"

  tags = {
    Name = "${var.cluster_name}"
  }
}

resource "aws_security_group_rule" "enable_ssh_port_22" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = "${var.ssh_location}"
  security_group_id = "${aws_security_group.kafka_client_instance.id}"
}

resource "aws_security_group_rule" "zk_2181_ingress" {
  type                     = "ingress"
  from_port                = 2181
  to_port                  = 2181
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.kafka_client_instance.id}"
  security_group_id        = "${var.msk_security_group_id}"
}

resource "aws_security_group_rule" "kafka_9094_ingress" {
  type                     = "ingress"
  from_port                = 9094
  to_port                  = 9094
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.kafka_client_instance.id}"
  security_group_id        = "${var.msk_security_group_id}"
}

resource "aws_security_group_rule" "kafka_9092_ingress" {
  type                     = "ingress"
  from_port                = 9092
  to_port                  = 9092
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.kafka_client_instance.id}"
  security_group_id        = "${var.msk_security_group_id}"
}

## EC2 Roles

data "aws_ami" "amazon-linux-2-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy" "full_msk_access" {
  arn = "arn:aws:iam::aws:policy/AmazonMSKFullAccess"
}

resource "aws_iam_instance_profile" "ec2_msk" {
  name = "EC2-MSK-Instance-Profile"
  role = "${aws_iam_role.full_msk_access.name}"
}

resource "aws_iam_role" "full_msk_access" {
  name               = "Full-MSK-Access"
  path               = "/"
  assume_role_policy = "${data.aws_iam_policy_document.instance_assume_role_policy.json}"

  tags = {
    Name = "${var.cluster_name}"
  }
}

resource "aws_iam_role_policy_attachment" "full_msk_access" {
  role       = "${aws_iam_role.full_msk_access.name}"
  policy_arn = "${data.aws_iam_policy.full_msk_access.arn}"
}

# EC2 Client Instance

data "aws_availability_zones" "available" {
  state = "available"
}

data "template_file" "client_script" {
  template = "${file("${path.module}/templates/client.tpl")}"

  vars {
    kafka_version      = "2.2.1"
    kafka_package_name = "kafka_2.12-2.2.1"
  }
}

data "template_cloudinit_config" "client_instance_config" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.client_script.rendered}"
  }
}

resource "aws_instance" "client_instance" {
  ami                    = "${data.aws_ami.amazon-linux-2-ami.id}"
  instance_type          = "${var.client_instance_type}"
  availability_zone      = "${element(data.aws_availability_zones.available.names, 0)}"
  subnet_id              = "${var.client_subnet_id}"
  iam_instance_profile   = "${aws_iam_instance_profile.ec2_msk.name}"
  key_name               = "${var.keypair_name}"
  vpc_security_group_ids = ["${aws_security_group.kafka_client_instance.id}", "${var.default_security_group_id}"]

  #user_data_base64 = "${data.template_cloudinit_config.client_instance_config.rendered}"
  user_data = "${data.template_cloudinit_config.client_instance_config.rendered}"

  tags = {
    Name    = "MSK-Client-Instance"
    Cluster = "${var.cluster_name}"
  }
}
