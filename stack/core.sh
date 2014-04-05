#!/bin/bash
FILE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NGINX_DIR=/etc/nginx
###################
# Install Nginx
###################
sudo apt-get install -y nginx
# Install nginx from source for socket.io
# wget http://nginx.org/download/nginx-1.4.3.tar.gz 
# tar xvzf nginx-1.4.3.tar.gz 
# ./configure
# make
# sudo make install
# sudo ln -s /sbin/nginx /usr/sbin
sudo mv $NGINX_DIR/nginx.conf $NGINX_DIR/nginx.conf.backup
sudo cp -i $FILE_DIR/nginx.conf $NGINX_DIR
sudo mv $NGINX_DIR/sites-enabled $NGINX_DIR/sites-enabled.backup
sudo cp -ir $FILE_DIR/sites-available/ $NGINX_DIR/sites-enabled
###################
# Install MySql
###################
sudo apt-get install -q -y mysql-server
# TODO: import mysql file
# sudo cp -i $FILE_DIR/lamp/my.cnf /etc/mysql/my.conf
# mysqladmin -u root -p password partyRhin0!
# sudo mysql_secure_installation
# create database and import dumpfile
# echo "create database p_petition" | mysql -u root -ppartyRhin0!
# mysql -u root -ppartyRhin0! p_petition < $FILE_DIR/p_petition.sql
###################
# Install PHP 5.5
###################
sudo add-apt-repository -y ppa:ondrej/php5
sudo apt-get update
sudo apt-get install -y php5 
sudo apt-get install -y php-pear php5-mysql php5-suhosin
sudo apt-get install -y mysql-server
sudo service apache2 start
###################
# Install Node Stable
###################
sudo apt-get update
sudo apt-get install -y python-software-properties python g++ make
sudo add-apt-repository -y ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install -y nodejs
# https://npmjs.org/ cache clean just in case
sudo npm cache clean
sudo npm install -g bower grunt-cli forever coffee-script node-inspector
###################
# Install Varnish via https://www.varnish-cache.org/installation/ubuntu
###################
curl http://repo.varnish-cache.org/debian/GPG-key.txt | sudo apt-key add -
echo "deb http://repo.varnish-cache.org/ubuntu/ precise varnish-3.0" | sudo tee -a /etc/apt/sources.list
sudo apt-get update
sudo apt-get install -y varnish
sudo patch /etc/default/varnish < $FILE_DIR/varnish.diff
sudo patch /etc/varnish/default.vcl < $FILE_DIR/default.vcl.diff
# Stop Varnish and Nginx for Ghost installation
sudo service nginx stop
sudo service varnish stop
cd $FILE_DIR
sudo ./ghost.sh
sudo service nginx start
sudo service varnish start
