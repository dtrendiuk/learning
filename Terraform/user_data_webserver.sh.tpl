#!/bin/bash

#########Nginx + PHP#########################
sudo yum update -y
sudo yum install -y gcc make
sudo amazon-linux-extras install epel -y
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo amazon-linux-extras install php7.2 nginx1.12 -y

sudo systemctl enable nginx
sudo systemctl enable php-fpm.service
sudo systemctl start nginx
sudo systemctl start php-fpm.service

###########################AWSLOGS#################################################################

sudo yum install -y awslogs
sudo sed -i -e "s/region = us-east-1/region = ${region}/g" /etc/awslogs/awscli.conf
sudo systemctl start awslogsd
sudo chkconfig awslogs on
sudo systemctl enable awslogsd.service

sudo bash -c 'cat >> /etc/awslogs/awslogs.conf << EOF

[/var/log/audit/audit.log]
datetime_format = %b %d %H:%M:%S
file = /var/log/audit/audit.log
buffer_duration = 5000
log_stream_name = {instance_id}
initial_position = start_of_file
log_group_name = auditlogs

[/var/log/nginx/access.log]
datetime_format = %b %d %H:%M:%S
file = /var/log/nginx/access.log
buffer_duration = 5000
log_stream_name = {instance_id}
initial_position = start_of_file
log_group_name = /var/log/nginx/access.log

[/var/log/nginx/error.log]
datetime_format = %b %d %H:%M:%S
file = /var/log/nginx/error.log
buffer_duration = 5000
log_stream_name = {instance_id}
initial_position = start_of_file
log_group_name = /var/log/nginx/error.log

EOF'

sudo systemctl start awslogsd
sudo systemctl status awslogsd

#################################################################################
