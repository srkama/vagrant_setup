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
#          ZSH setup
# ---------------------------------------
apt-get -y install git zsh
su vagrant -c "git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh-folder"
su vagrant -c "~/.oh-my-zsh-folder/tools/install.sh -y"
su vagrant -c "sed -i 's/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"clean\"/g' ~/.zshrc"
chsh -s /bin/zsh vagrant

# ---------------------------------------
#          Config Setting
# ---------------------------------------
git config --global core.autocrlf True

# ---------------------------------------
#          Dcoker-Compose  setup
# ---------------------------------------
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
