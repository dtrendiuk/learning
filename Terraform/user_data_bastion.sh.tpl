#!/bin/bash

#Install Ansible
sudo yum update -y
pip3 install ansible

#Install Git and clone repo
sudo yum install git -y
mkdir /home/ec2-user/ansible
git clone https://github.com/dtrendiuk/learning.git /home/ec2-user/ansible/
cd /home/ec2-user/ansible/ansible/
ansible-galaxy collection install amazon.aws
pip3 install --user boto3

#Add SSH key
sudo bash -c 'cat >> /home/ec2-user/.ssh/ansible.pem << EOF
${ansible_private_key}
EOF'
chmod 400 /home/ec2-user/.ssh/ansible.pem
sudo chown -R ec2-user:ec2-user /home/ec2-user/.ssh/

# Run ansible-playbook -- executed via Jenkinsfile
# ansible-playbook -i inventory_aws_ec2.yml playbook.yml
