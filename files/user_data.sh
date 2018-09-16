#!/bin/bash
yum update -y
yum install -y nfs-utils docker
service docker start
usermod -a -G docker ec2-user
mkdir -p /mnt/efs
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 ${EFS_MOUNT_DNS}:/ /mnt/efs
mkdir -p /mnt/efs/uploads
chown ec2-user:ec2-user /mnt/efs/uploads
chmod 777 /mnt/efs/uploads

docker pull wordpress
docker run --name wordpress -p 80:80 -e WORDPRESS_DB_HOST=${WORDPRESS_DB_HOST}:3306 \
-e WORDPRESS_DB_USER=${WORDPRESS_DB_USER} -e WORDPRESS_DB_PASSWORD=${WORDPRESS_DB_PASSWORD} \
--mount type=bind,source=/mnt/efs/uploads,target=/var/www/html/wp-content/uploads \
-d wordpress
