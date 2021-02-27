#!/usr/bin/env bash

# Updating packages
apt-get update

# ---------------------------------------
#          MySQL Setup
# ---------------------------------------

# Setting MySQL root user password root/root
debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'


# Installing packages
apt-get install -y mysql-server mysql-client

# Allow External Connections on your MySQL Service
sudo sed -i -e 's/bind-addres/#bind-address/g' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo sed -i -e 's/skip-external-locking/#skip-external-locking/g' /etc/mysql/mysql.conf.d/mysqld.cnf
mysql -u root -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root'; FLUSH privileges;"
sudo service mysql restart
# create client database
mysql -u root -proot -e "CREATE DATABASE myDB;"


# ---------------------------------------
#          redis setup
# ---------------------------------------

# installing redis
apt-get install -y redis-server

#enabling the redis
systemctl enable redis-server.service


# ---------------------------------------
#          docker setup
# ---------------------------------------

apt-get install -y apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

apt-get update

apt-cache policy docker-ce

apt-get install -y docker-ce

systemctl status docker

usermod -aG docker vagrant

# ---------------------------------------
#          python setup
# ---------------------------------------

apt-get -y install python3.8
apt-get -y install -y python3-pip

# ---------------------------------------
#          packaages setup
# ---------------------------------------

apt-add-repository ppa:fish-shell/release-3
apt-get -y install git fish neofetch fonts-powerline tree

# ---------------------------------------
#          fish setup
# ---------------------------------------

snap install startship 
chsh -s /usr/bin/fish 

# ---------------------------------------
#          git config
# ---------------------------------------

git config --global core.autocrlf True
git config --global credential.helper store

# ---------------------------------------
#          micro editor setup
# ---------------------------------------

curl https://getmic.ro | bash

cp micro /usr/local/bin

chmod +x /usr/local/bin/micro

# ---------------------------------------
#          Dcoker-Compose  setup
# ---------------------------------------
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
