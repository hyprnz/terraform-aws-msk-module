## Security Groups

resource "aws_security_group" "kafka_client_instance" {
  name        = "MSK-Client-Instance"
  description = "Grants access to MSK cluster resources"
  vpc_id      = var.cluster_vpc_id

  tags = merge(map("MSK Cluster", var.cluster_name), var.tags)
}

resource "aws_security_group_rule" "zk_2181_ingress" {
  type                     = "ingress"
  from_port                = 2181
  to_port                  = 2181
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.kafka_client_instance.id
  security_group_id        = var.msk_security_group_id
}

resource "aws_security_group_rule" "kafka_9094_ingress" {
  type                     = "ingress"
  from_port                = 9094
  to_port                  = 9094
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.kafka_client_instance.id
  security_group_id        = var.msk_security_group_id
}

resource "aws_security_group_rule" "kafka_9092_ingress" {
  type                     = "ingress"
  from_port                = 9092
  to_port                  = 9092
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.kafka_client_instance.id
  security_group_id        = var.msk_security_group_id
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

resource "aws_iam_instance_profile" "ec2_msk" {
  name = "EC2-MSK-Instance-Profile"
  role = aws_iam_role.full_msk_access.name
}

resource "aws_iam_role" "full_msk_access" {
  name               = "Full-MSK-Access"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.instance_assume_role_policy.json

  tags = merge(map("MSK Cluster", var.cluster_name), var.tags)
}

data "aws_iam_policy_document" "session_manager" {
  statement {
    sid = "SessionManagerClientAccess"

    actions = [
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel",
      "ssm:UpdateInstanceInformation"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "session_manager" {
  name        = "SessionManager-EC2UserData-AllowSessions"
  description = "Grants actions to allow a EC2 instance to establish connections to Session Manager"
  path        = "/"
  policy      = data.aws_iam_policy_document.session_manager.json
}

data "aws_iam_policy_document" "cwagent" {
  statement {
    sid = "CWAgentLogAccess"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams"
    ]

    resources = ["arn:aws:logs:*:*:*"]
  }

  statement {
    sid = "CWAgentMetrciAccess"

    actions = [
      "cloudwatch:PutMetricData"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "cwagent" {
  name        = "CloudWatch-EC2UserData-AllowLogAndMetrics"
  description = "Grants actions to allow a EC2 instance to put logs and metrics to CloudWatch"
  path        = "/"
  policy      = data.aws_iam_policy_document.cwagent.json
}

data "aws_iam_policy" "full_msk_access" {
  arn = "arn:aws:iam::aws:policy/AmazonMSKFullAccess"
}

resource "aws_iam_role_policy_attachment" "full_msk_access" {
  role       = aws_iam_role.full_msk_access.name
  policy_arn = data.aws_iam_policy.full_msk_access.arn
}

resource "aws_iam_role_policy_attachment" "session_manager" {
  role       = aws_iam_role.full_msk_access.name
  policy_arn = aws_iam_policy.session_manager.arn
}

resource "aws_iam_role_policy_attachment" "cwagent" {
  role       = aws_iam_role.full_msk_access.name
  policy_arn = aws_iam_policy.cwagent.arn
}

# EC2 Client Instance

data "template_file" "session_manager" {
  template = file("${path.module}/templates/session_manager.tpl")
}

data "template_file" "cwagent" {
  template = file("${path.module}/templates/cwagent.tpl")

  vars = {
    log_group_name = var.cwagent_log_group_name
  }
}

data "template_file" "client_script" {
  template = file("${path.module}/templates/client.tpl")

  vars = {
    kafka_version      = "2.2.1"
    kafka_package_name = "kafka_2.12-2.2.1"
  }
}

data "template_cloudinit_config" "client_instance_config" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.session_manager.rendered
  }

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.cwagent.rendered
  }

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.client_script.rendered
  }
}

resource "aws_cloudwatch_log_group" "instance_log_group" {
  name              = var.cwagent_log_group_name
  retention_in_days = var.cwagent_log_group_retention_period

  tags = merge(map("MSK Cluster", var.cluster_name), var.tags)
}

resource "aws_instance" "client_instance" {
  ami                    = data.aws_ami.amazon-linux-2-ami.id
  instance_type          = var.client_instance_type
  subnet_id              = var.client_subnet_id
  iam_instance_profile   = aws_iam_instance_profile.ec2_msk.name
  vpc_security_group_ids = [aws_security_group.kafka_client_instance.id, var.default_security_group_id]

  user_data = data.template_cloudinit_config.client_instance_config.rendered

  tags = merge(map("Name", "MSK-Client-Instance"), map("MSK Cluster", var.cluster_name), var.tags)
}
