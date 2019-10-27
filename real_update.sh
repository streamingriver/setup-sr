#!/bin/bash


ansible-playbook -i /opt/tools/_etc/ansible_host_sr playbooks/files.yml || true
ansible-playbook -i /opt/tools/_etc/ansible_host_sr playbooks/supervisord.yml || true
ansible-playbook -i /opt/tools/_etc/ansible_host_sr playbooks/mysql-migrations.yml || true

restorecon -R /var/www/sr # 

supervisorctl update


