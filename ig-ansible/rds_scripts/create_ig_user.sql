create user image_gallery login password 'simple';
grant image_gallery to postgres;
create database image_gallery owner image_gallery;
grant image_gallery to image_gallery;
\q
