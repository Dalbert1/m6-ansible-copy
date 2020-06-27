#!/bin/bash

if [ "$#" != "2" ]; then
	sudo yum update -y
	sudo yum install -y git
	sudo yum install -y python3
	sudo yum install -y postgresql
	sudo yum install -y gcc
	sudo yum install -y python3-devel
	sudo yum install -y postgresql-devel
	sudo pip3 install --user psycopg2
	sudo pip3 install boto3
	cd /home/ec2-user
	git clone https://github.com/Dalbert1/python-image-gallery.git
	git clone https://github.com/Dalbert1/ig_ansible_boot.git
	chown -R ec2-user:ec2-user python-image-gallery

	#export POSTGRES_HOST="some-host.com" # $1 arg 1
	#export POSTGRES_PORT="5432" # $2 arg 1
	#export POSTGRES_DATABASE="some_database" # $3 arg 1
	#export POSTGRES_USERNAME="some_user" # $4 arg 1
	#export POSTGRES_PASSWORD="some_password" # $5 arg 1

	cd ig-ansible
	
	export PGPASSWORD=$2;
	psql -h $1 -U postgres -f ./rds_scripts/create_ig_user.sql
	#psql -h $1 -U image_gallery -d image_gallery -f ./rds_scripts/create_users_tbl.sql
	exit 1
fi
