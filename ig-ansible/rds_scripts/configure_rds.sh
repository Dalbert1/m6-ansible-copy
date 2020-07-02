#!/bin/bash
sudo yum update -y
sudo yum install -y git
sudo yum install -y python3
sudo yum install -y postgresql
sudo yum install -y gcc
sudo yum install -y python3-devel
sudo yum install -y postgresql-devel
sudo yum install -y jq # json parser
sudo pip3 install psycopg2
sudo pip3 install boto3
cd /home/ec2-user
pip3 install --user boto3
pip3 install --user psycopg2
git clone https://github.com/Dalbert1/m6-python-ig-copy.git
git clone https://github.com/Dalbert1/m6-ansible-copy.git
amazon-linux-extras install -y nginx1

chown -R ec2-user:ec2-user m6-python-ig-copy
chown -R ec2-user:ec2-user ig_ansible_boot
cd /home/ec2-user/m6-ansible-copy/ig-ansible
export AWS_DEFAULT_REGION=us-west-2
export AWS_DEFAULT_OUTPUT=json
export PGPASSWORD=$(aws secretsmanager get-secret-value --secret-id m6sec-ig-postgres | jq --raw-output .SecretString | jq -r ."password")
export PGUSER=$(aws secretsmanager get-secret-value --secret-id m6sec-ig-postgres | jq --raw-output .SecretString | jq -r ."username")
export PGHOST=$(aws secretsmanager get-secret-value --secret-id m6sec-ig-postgres | jq --raw-output .SecretString | jq -r ."host")
psql  -f ./rds_scripts/create_ig_user.sql -v v1=\'$(aws secretsmanager get-secret-value --secret-id m6sec-ig-image_gallery | jq --raw-output .SecretString | jq -r ."password")\'
export PGDATABASE=$(aws secretsmanager get-secret-value --secret-id m6sec-ig-image_gallery | jq --raw-output .SecretString | jq -r ."database_name")
export PGUSER=$(aws secretsmanager get-secret-value --secret-id m6sec-ig-image_gallery | jq --raw-output .SecretString | jq -r ."username")
export PGPASSWORD=$(aws secretsmanager get-secret-value --secret-id m6sec-ig-image_gallery | jq --raw-output .SecretString | jq -r ."password")
psql -f ./rds_scripts/create_users_tbl.sql

cd ../../m6-python-ig-copy
sudo pip3 install -r ~./requirements.txt
exit 1

#/var/log/boot.log  ---  System boot log