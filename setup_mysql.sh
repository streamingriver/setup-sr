#!/bin/bash

ansible-playbook -i /opt/tools/_etc/ansible_host_sr playbooks/mysql-config.yml
ansible-playbook -i /opt/tools/_etc/ansible_host_sr playbooks/mysql-migrations.yml
