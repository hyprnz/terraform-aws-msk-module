data "aws_region" "current" {}

locals {
  create_dashboard = "${var.create_dashboard == "true" ? 1 : 0}"
  custom_dashboard = "${var.custom_dashboard_template}"

  dashboard_template = "${length(local.custom_dashboard) > 0 ? local.custom_dashboard : "${path.module}/templates/dashboard-default.tpl"}"
}

data "template_file" "msk_dashboard" {
  count = "${local.create_dashboard}"

  template = "${file(local.dashboard_template)}"

  vars {
    cluster_name = "${var.cluster_name}"
    region       = "${data.aws_region.current.name}"
  }
}

# Current Dashboard based on DataDog MSK Overview Dashboard
# discussed in an article on their blog:
#   https://www.datadoghq.com/blog/monitor-amazon-msk/

resource "aws_cloudwatch_dashboard" "msk" {
  count = "${local.create_dashboard}"

  dashboard_name = "${var.cluster_name}"
  dashboard_body = "${data.template_file.msk_dashboard.rendered}"
}
