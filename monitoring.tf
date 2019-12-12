data "aws_region" "current" {}

locals {
  create_dashboard = "${var.create_dashboard == "true" ? 1 : 0}"
}

# Current Dashboard based on DataDog MSK Overview Dashboard
# discussed in an article on their blog:
#   https://www.datadoghq.com/blog/monitor-amazon-msk/

resource "aws_cloudwatch_dashboard" "msk" {
  count = "${local.create_dashboard}"

  dashboard_name = "${var.cluster_name}"

  dashboard_body = <<EOF
{
    "widgets": [
        {
            "type": "text",
            "x": 0,
            "y": 0,
            "width": 6,
            "height": 6,
            "properties": {
                "markdown": "![Kafka Logo](https://raw.githubusercontent.com/hyprnz/terraform-aws-msk-module/0.11-initial-example/assets/Kafka-Logo-200.jpg)"
            }
        },
        {
            "type": "metric",
            "x": 0,
            "y": 6,
            "width": 6,
            "height": 3,
            "properties": {
                "view": "singleValue",
                "metrics": [
                    [ "AWS/Kafka", "OfflinePartitionsCount", "Cluster Name", "${var.cluster_name}" ]
                ],
                "region": "${data.aws_region.current.name}",
                "period": 300,
                "title": "Offline Partions"
            }
        },
        {
            "type": "metric",
            "x": 6,
            "y": 0,
            "width": 6,
            "height": 6,
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/Kafka", "CpuUser", "Cluster Name", "${var.cluster_name}", "Broker ID", "1" ],
                    [ "...", "2" ],
                    [ "...", "3" ]
                ],
                "region": "${data.aws_region.current.name}",
                "title": "User CPU"
            }
        },
        {
            "type": "metric",
            "x": 12,
            "y": 0,
            "width": 6,
            "height": 6,
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/Kafka", "KafkaDataLogsDiskUsed", "Cluster Name", "${var.cluster_name}", "Broker ID", "1" ],
                    [ "...", "2" ],
                    [ "...", "3" ]
                ],
                "region": "${data.aws_region.current.name}",
                "title": "Disk Usage (data logs)"
            }
        },
        {
            "type": "metric",
            "x": 18,
            "y": 0,
            "width": 6,
            "height": 6,
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/Kafka", "MemoryFree", "Cluster Name", "${var.cluster_name}", "Broker ID", "1" ],
                    [ "...", "2" ],
                    [ "...", "3" ]
                ],
                "region": "${data.aws_region.current.name}",
                "title": "Free Memory by broker"
            }
        },
        {
            "type": "metric",
            "x": 6,
            "y": 6,
            "width": 6,
            "height": 6,
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/Kafka", "CpuSystem", "Cluster Name", "${var.cluster_name}", "Broker ID", "1" ],
                    [ "...", "2" ],
                    [ "...", "3" ]
                ],
                "region": "${data.aws_region.current.name}",
                "title": "System CPU"
            }
        },
        {
            "type": "metric",
            "x": 12,
            "y": 6,
            "width": 6,
            "height": 6,
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/Kafka", "KafkaAppLogsDiskUsed", "Cluster Name", "${var.cluster_name}", "Broker ID", "1" ],
                    [ "...", "2" ],
                    [ "...", "3" ]
                ],
                "region": "${data.aws_region.current.name}",
                "title": "Disk Usage (application logs)"
            }
        },
        {
            "type": "metric",
            "x": 18,
            "y": 6,
            "width": 6,
            "height": 6,
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/Kafka", "MemoryUsed", "Cluster Name", "${var.cluster_name}", "Broker ID", "1" ],
                    [ "...", "2" ],
                    [ "...", "3" ]
                ],
                "region": "${data.aws_region.current.name}",
                "title": "Used Memory by broker"
            }
        },
        {
            "type": "metric",
            "x": 0,
            "y": 9,
            "width": 6,
            "height": 6,
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/Kafka", "ZooKeeperRequestLatencyMsMean", "Cluster Name", "${var.cluster_name}" ]
                ],
                "region": "${data.aws_region.current.name}",
                "title": "Average Zookeeper request latency (ms)"
            }
        }
    ]
}
EOF

}
