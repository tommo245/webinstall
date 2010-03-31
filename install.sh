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

# Create web dirs, and shortcuts
mkdir -p /usr/share/www/seo_dynamic
ln -s /usr/share/www /www

# Install the seo system 
svn co svn://10.255.130.18/seosystem/trunk/seoadmin/ /usr/share/www/seo_dynamic/seoadmin --username=bent --password=huginamug
svn co svn://10.255.130.18/seosystem/trunk/seosupport/ /usr/share/www/seo_dynamic/seosupport --username=bent --password=huginamug

# Grab the vhosts, put them where they need to be
svn export svn://10.255.130.18/seosystem/trunk/conf/hosts/hxseo /etc/apache2/sites-available/hxseo --username=bent --password=huginamug

a2dissite default
a2ensite hxseo

# Restart apache
/etc/init.d/apache2 reload

# Prob want to get pollingStation in here, in the absence of cruise.

