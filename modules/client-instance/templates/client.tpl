#!/bin/bash
yum update -y 
yum install java-1.8.0-openjdk-devel -y
cd /home/ec2-user
echo "export PATH=.local/bin:$PATH" >> .bash_profile
mkdir kafka
cd kafka
wget https://archive.apache.org/dist/kafka/${kafka_version}/${kafka_package_name}.tgz
tar -xzf ${kafka_package_name}.tgz
cd /home/ec2-user
chown -R ec2-user ./kafka
chgrp -R ec2-user ./kafka
