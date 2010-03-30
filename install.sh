#!/bin/bash

aptitude update
aptitude -y safe-upgrade

# install PHP
apt-get install -y php5-cli

# install PHP-dev
# need some tools including phpize
apt-get install -y php5-dev

# Install apache
aptitude -y install libapache2-mod-wsgi

# Install PEAR
# PEAR needs to be >=1.8.0 for PHING + dependencies, above cmd only gets 1.7.x
# so...upgrade
apt-get -y install php-pear
pear upgrade PEAR

# Install Subversion
apt-get -y install subversion

# Install Phing
# Used for deploying stuff
pear channel-discover pear.phing.info
pear install --alldeps phing/phing

# Install Cruise
# and deal with licenses


# Install the seo system (admin dir first)
svn co svn://10.255.130.18/seosystem/trunk/seoadmin/ /usr/local/src/seoadmin --username=bent --password=huginamug 

