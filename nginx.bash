#!/usr/bin/env bash

echo '>> Installing git'

yum install git -y

echo '>> Installing nano'

yum install nano -y

echo '>> Installing wget'

yum install wget -y

echo '>> Installing NGINX'

yum install epel-release -y

yum install nginx -y

systemctl start nginx -y

firewall-cmd --permanent --zone=public --add-service=http 

firewall-cmd --permanent --zone=public --add-service=https

firewall-cmd --reload

sudo systemctl enable nginx -y

echo '>> Install PHP'

yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -y

yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y

yum install yum-utils -y

yum-config-manager --enable remi-php73

yum install php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo php-xml php-mbstring -y

php -v
 
echo '>> Install Composer'

yum install php-cli php-zip wget unzip -y

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

HASH="$(wget -q -O - https://composer.github.io/installer.sig)"

php -r "if (hash_file('SHA384', 'composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"

php composer-setup.php --install-dir=/usr/local/bin --filename=composer

echo '>> Install Redis'

yum install epel-release -y

yum install redis -y

systemctl start redis.service

systemctl enable redis

systemctl status redis.service

redis-cli ping

echo '>> Install MySQL'

wget https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm

md5sum mysql57-community-release-el7-9.noarch.rpm

rpm -ivh mysql57-community-release-el7-9.noarch.rpm

yum install mysql-server -y

systemctl start mysqld

systemctl status mysqld

systemctl enable mysqld

grep 'temporary password' /var/log/mysqld.log

mysql_secure_installation

echo '>> Done'

