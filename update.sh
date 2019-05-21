#!/bin/bash

git pull

ansible-playbook -i /opt/tools/_etc/ansible_host_sr playbooks/files.yml
ansible-playbook -i /opt/tools/_etc/ansible_host_sr playbooks/supervisord.yml
ansible-playbook -i /opt/tools/_etc/ansible_host_sr playbooks/mysql-migrations.yml
