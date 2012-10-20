#!/usr/bin/env bash

# Setup Apache, MySql, PHP


# Install VM packages.
apt-packages-install     \
  apache2-mpm-worker     \
  apache2-suexec-custom  \
  mysql-server           \
  libapache2-mod-fastcgi \
  php5-cgi               \
  php5-gd                \
  php5-mysql             \
  php-pear               \
  memcached

php-pecl-install mongo

# Allow modules for Apache.
apache-modules-enable actions rewrite fastcgi suexec

# Replace the default Apache site.
apache-sites-disable default default-ssl

# Create apache vhost
VHOSTNAME='precise64'
if [ ! -e /etc/apache2/sites-available/$VHOSTNAME ]; then
  PHP=/usr/bin/php-cgi EXTRA='  ServerName precise64' apache-sites-create $VHOSTNAME '/vagrant/www' 'vagrant'
  apache-sites-enable $VHOSTNAME
fi
apache-restart

# Allow unsecured remote access to MySQL.
mysql-remote-access-allow

# Restart MySQL service for changes to take effect.
mysql-restart

# Set PHP timezone
php-settings-update 'date.timezone' 'America/Los_Angeles'

