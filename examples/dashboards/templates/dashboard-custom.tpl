{
    "widgets": [
        {
            "type": "text",
            "x": 0,
            "y": 0,
            "width": 6,
            "height": 6,
            "properties": {
                "markdown": "![Kafka Logo](https://raw.githubusercontent.com/hyprnz/terraform-aws-msk-module/master/assets/Kafka-Logo-200.jpg)"
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
                    [ "AWS/Kafka", "OfflinePartitionsCount", "Cluster Name", "${cluster_name}" ]
                ],
                "region": "${region}",
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
                    [ "AWS/Kafka", "CpuUser", "Cluster Name", "${cluster_name}", "Broker ID", "1" ],
                    [ "...", "2" ],
                    [ "...", "3" ]
                ],
                "region": "${region}",
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
                    [ "AWS/Kafka", "KafkaDataLogsDiskUsed", "Cluster Name", "${cluster_name}", "Broker ID", "1" ],
                    [ "...", "2" ],
                    [ "...", "3" ]
                ],
                "region": "${region}",
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
                    [ "AWS/Kafka", "MemoryFree", "Cluster Name", "${cluster_name}", "Broker ID", "1" ],
                    [ "...", "2" ],
                    [ "...", "3" ]
                ],
                "region": "${region}",
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
                    [ "AWS/Kafka", "CpuSystem", "Cluster Name", "${cluster_name}", "Broker ID", "1" ],
                    [ "...", "2" ],
                    [ "...", "3" ]
                ],
                "region": "${region}",
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
                    [ "AWS/Kafka", "KafkaAppLogsDiskUsed", "Cluster Name", "${cluster_name}", "Broker ID", "1" ],
                    [ "...", "2" ],
                    [ "...", "3" ]
                ],
                "region": "${region}",
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
                    [ "AWS/Kafka", "MemoryUsed", "Cluster Name", "${cluster_name}", "Broker ID", "1" ],
                    [ "...", "2" ],
                    [ "...", "3" ]
                ],
                "region": "${region}",
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
                    [ "AWS/Kafka", "ZooKeeperRequestLatencyMsMean", "Cluster Name", "${cluster_name}" ]
                ],
                "region": "${region}",
                "title": "Average Zookeeper request latency (ms)"
            }
        },
        {
            "type": "metric",
            "x": 0,
            "y": 9,
            "width": 6,
            "height": 3,
            "properties": {
                "metrics": [
                    [ { "expression": "SUM([m1,m2,m3])", "label": "UnderReplicated", "id": "total" } ],
                    [ "AWS/Kafka", "UnderReplicatedPartitions", "Cluster Name", "${cluster_name}", "Broker ID", "1", { "id": "m1", "visible": false } ],
                    [ "...", "2", { "id": "m2", "visible": false } ],
                    [ "...", "3", { "id": "m3", "visible": false } ]
                ],
                "view": "singleValue",
                "region": "${region}",
                "stat": "Maximum",
                "period": 300,
                "title": "Under Replicated"
            }
        }
    ]
}
