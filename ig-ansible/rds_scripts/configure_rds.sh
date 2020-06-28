#!/bin/bash

if [ "$#" != "1" ]; then
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
	git clone https://github.com/Dalbert1/python-image-gallery.git
	git clone https://github.com/Dalbert1/ig_ansible_boot.git
	chown -R ec2-user:ec2-user python-image-gallery
	chown -R ec2-user:ec2-user ig_ansible_boot
	cd /ig_ansible_boot/ig-ansible
	export AWS_DEFAULT_REGION=us-east-2
	export AWS_DEFAULT_OUTPUT=json
	export PGPASSWORD=$(aws secretsmanager get-secret-value --secret-id sec-ig-postgres | jq --raw-output .SecretString | jq -r ."password")
	export PGUSER=$(aws secretsmanager get-secret-value --secret-id sec-ig-postgres | jq --raw-output .SecretString | jq -r ."username")
	export PGHOST=$(aws secretsmanager get-secret-value --secret-id sec-ig-postgres | jq --raw-output .SecretString | jq -r ."host")
	psql  -f ./rds_scripts/create_ig_user.sql
	export PGDATABASE=$(aws secretsmanager get-secret-value --secret-id sec-m5-ig-image_gallery | jq --raw-output .SecretString | jq -r ."database_name")
	export PGUSER=$(aws secretsmanager get-secret-value --secret-id sec-m5-ig-image_gallery | jq --raw-output .SecretString | jq -r ."username")
	export PGPASSWORD=$(aws secretsmanager get-secret-value --secret-id sec-m5-ig-image_gallery | jq --raw-output .SecretString | jq -r ."password")
	psql -f ./rds_scripts/create_users_tbl.sql
	exit 1
fi


# CAN GET RANDOM PASSWORDS WITH AWS CLI