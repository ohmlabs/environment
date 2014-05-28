#!/bin/bash
FILE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NGINX_DIR=/etc/nginx
#------------------
# Install Nginx
#------------------
# Installation from source:
# wget http://nginx.org/download/nginx-1.4.3.tar.gz
# --------------------------
# tar xvzf (.tgz or tar.gz)
# tar xvjf (.tbz or .tar.bz2)
# tar xvf (.tar)
# --------------------------
# sudo tar xvf nginx-1.4.3.tar.gz
# cd nginx-1.4.3
# sudo ./configure
# sudo make
# sudo make install
# sudo ln -s /sbin/nginx /usr/sbin
sudo add-apt-repository ppa:nginx/stable  # use nginx=development for latest development version
sudo apt-get update
sudo apt-get install -y nginx
sudo mv $NGINX_DIR/nginx.conf $NGINX_DIR/nginx.conf.backup
sudo cp -i $FILE_DIR/nginx.conf $NGINX_DIR
sudo mv $NGINX_DIR/sites-enabled $NGINX_DIR/sites-enabled.backup
sudo cp -ir $FILE_DIR/../sites-available/ $NGINX_DIR/sites-enabled
#------------------
# Install Node Stable
#------------------
sudo apt-get update
sudo apt-get install -y python-software-properties python g++ make
sudo add-apt-repository -y ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install -y nodejs
# https://npmjs.org/ cache clean just in case
sudo npm cache clean
sudo npm install -g bower grunt-cli forever coffee-script node-inspector
#-------------------
# Install Varnish via https://www.varnish-cache.org/installation/ubuntu
#-------------------
curl http://repo.varnish-cache.org/debian/GPG-key.txt | sudo apt-key add -
echo "deb http://repo.varnish-cache.org/ubuntu/ precise varnish-3.0" | sudo tee -a /etc/apt/sources.list
sudo apt-get update
sudo apt-get install -y varnish
sudo cp /etc/varnish/default.vcl /etc/varnish/default.vcl.old
sudo patch /etc/default/varnish < $FILE_DIR/varnish.diff
sudo patch /etc/varnish/default.vcl < $FILE_DIR/default.vcl.diff
# Stop Varnish and Nginx for Ghost installation
sudo service nginx stop
sudo service varnish stop
#------------------
# Install Ghost
#------------------
# This is run within the boilerplate, to install independently uncomment this:
# cd $FILE_DIR
# sudo ./ghost.sh
sudo service nginx start
sudo service varnish start