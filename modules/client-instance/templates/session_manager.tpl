#!/bin/bash
echo "====== Configuring SSM..."

sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
sudo systemctl status amazon-ssm-agent

echo "====== SSM script complete"