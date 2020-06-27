#!/bin/bash

if [ "$#" != "1" ]; then
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
	chown -R ec2-user:ec2-user python-image-gallery

# PASS IN PARAMETERS FOR IMAGE GALLERY DB
echo "
create user image_gallery login password 'simple';
grant image_gallery to postgres;
create database image_gallery owner image_gallery;
grant image_gallery to image_gallery;
\q
" >> create_ig_user.sql

echo "
create table users (username varchar(100) primary key, password varchar(100), full_name varchar(200));
insert into users values ('fred','foo','Fred Flinstone');
insert into users values ('Dalb','Al','D');
\q
" >> create_users_tbl.sql

	#psql -h $1 -U postgres -d image_gallery -f ./rds_scripts/create_ig_user.sql
	#psql -h $1 -U image_gallery -d image_gallery -f ./rds_scripts/create_users_tbl.sql
	exit 1
fi