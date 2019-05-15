#!/bin/bash
echo 
echo 
echo "###### ENTER YOUR SERVER INFORMATION ######"
echo 
echo 

read -p "Enter the FQDN (full hostname.domain.ltd): " hostname
read -p "Enter the IP address: " ip

mkdir -p /opt/tools/_etc

echo "${hostname} ansible_host=${ip} ansible_connection=local" > /opt/tools/_etc/ansible_host_sr

yum install epel-release -y --quiet > /dev/null
yum install -y ansible --quiet > /dev/null
yum install git-core pwgen -y --quiet > /dev/null

mkdir -p /opt/tools/_etc

if [ ! -f /opt/tools/_etc/secrets ]; then
    echo "mysql_root_pw: `pwgen 20`" > /opt/tools/_etc/secrets
    echo "sr_db_user: sriptvdba" >> /opt/tools/_etc/secrets
    echo "sr_db_pass: `pwgen 20`" >> /opt/tools/_etc/secrets
    echo "sr_db_name: sriptvdb" >> /opt/tools/_etc/secrets
    echo "sr_token: `pwgen 32`" >> /opt/tools/_etc/secrets
    echo "sr_web_user: iptvadmin" >> /opt/tools/_etc/secrets
    echo "sr_web_pass: `pwgen 20`" >> /opt/tools/_etc/secrets
    chmod 600 /opt/tools/_etc/secrets
fi

ansible-playbook -i /opt/tools/_etc/ansible_host_sr playbooks/software.yml 
ansible-playbook -i /opt/tools/_etc/ansible_host_sr playbooks/httpd-config.yml
ansible-playbook -i /opt/tools/_etc/ansible_host_sr playbooks/mysql-config.yml
ansible-playbook -i /opt/tools/_etc/ansible_host_sr playbooks/sr-config.yml
ansible-playbook -i /opt/tools/_etc/ansible_host_sr playbooks/selinux.yml
ansible-playbook -i /opt/tools/_etc/ansible_host_sr playbooks/firewalld.yml
ansible-playbook -i /opt/tools/_etc/ansible_host_sr playbooks/services.yml 
ansible-playbook -i /opt/tools/_etc/ansible_host_sr playbooks/cron.yml 

echo "go to http://${hostname}/site or http://${ip}/site and login with: "
tail -n 2 /opt/tools/_etc/secrets
