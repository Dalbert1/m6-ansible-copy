#!/bin/bash

if [ "$#" != "1" ]; then
	sudo yum update -y
	sudo yum install -y git
	sudo yum install -y python3
	sudo yum install -y postgresql
	sudo yum install -y gcc
	sudo yum install -y python3-devel
	sudo yum install -y postgresql-devel
	pip3 install --user psycopg2
	pip3 install --user boto3
	cd /home/ec2-user
	git clone https://github.com/Dalbert1/python-image-gallery.git
	git clone https://github.com/Dalbert1/ig_ansible_boot.git
	chown -R ec2-user:ec2-user python-image-gallery
	chown -R ec2-user:ec2-user ig_ansible_boot
	cd /ig_ansible_boot/ig-ansible
	#export PGPASSWORD='simple5678'
	#psql -h $1 -U postgres -f ./rds_scripts/create_ig_user.sql
	#export PGPASSWORD='simple'
	#psql -h $1 -U image_gallery -d image_gallery -f ./rds_scripts/create_users_tbl.sql
	#cd ig_ansible_boot/ig-ansible
	
	exit 1
fi
