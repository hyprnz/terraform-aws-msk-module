#!/bin/bash
echo "====== Configuring the cwagent..."

wget https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm
sudo rpm -U ./amazon-cloudwatch-agent.rpm

sudo cat <<-EOF > /opt/aws/amazon-cloudwatch-agent/bin/config.json
{
    "agent": {
        "metrics_collection_interval": 30,
        "run_as_user": "cwagent"
    },
    "logs": {
        "logs_collected": {
            "files": {
                "collect_list": [
                    {
                        "file_path": "/opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.log",
                        "log_group_name": "${log_group_name}",
                        "log_stream_name": "cloudwatch-agent-{instance_id}"
                    },
                    {
                        "file_path": "/var/log/messages",
                        "log_group_name": "${log_group_name}",
                        "log_stream_name": "syslog-{instance_id}"
                    },
                    {
                        "file_path": "/var/log/cloud-init-output.log",
                        "log_group_name": "${log_group_name}",
                        "log_stream_name": "cloud-init-output-{instance_id}"
                    }
                ]
            }
        }
    },
    "metrics": {
        "append_dimensions": {
            "ImageID":"\$${aws:ImageId}",
            "InstanceId":"\$${aws:InstanceId}",
            "InstanceType":"\$${aws:InstanceType}",
            "AutoScalingGroupName":"\$${aws:AutoScalingGroupName}"
        },
        "metrics_collected": {
            "cpu": {
                "measurement": [
                    "cpu_usage_idle",
                    "cpu_usage_iowait",
                    "cpu_usage_user",
                    "cpu_usage_system"
                ],
                "metrics_collection_interval": 30,
                "totalcpu": false
            },
            "disk": {
                "measurement": [
                    "used_percent",
                    "inodes_free"
                ],
                "metrics_collection_interval": 30,
                "resources": [
                    "*"
                ]
            },
            "diskio": {
                "measurement": [
                    "io_time"
                ],
                "metrics_collection_interval": 30,
                "resources": [
                    "*"
                ]
            },
            "mem": {
                "measurement": [
                    "mem_used_percent"
                ],
                "metrics_collection_interval": 30
            },
            "swap": {
                "measurement": [
                    "swap_used_percent"
                ],
                "metrics_collection_interval": 30
            }
        }
    }
}
EOF

#Give cwagent access to syslog
sudo setfacl -m u:cwagent:r /var/log/messages

sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json -s

echo "====== cwagent script complete"