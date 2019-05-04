#!/bin/bash

yum install epel-release -y --quiet
yum install -y ansible --quiet
yum install git-core -y --quiet

echo "`hostname -s` ansible_connection=local" > /tmp/ansible_host_sr


ansible-playbook -i /tmp/ansible_host_sr playbooks/software.yml 
ansible-playbook -i /tmp/ansible_host_sr playbooks/httpd-config.yml
ansible-playbook -i /tmp/ansible_host_sr playbooks/services.yml 

