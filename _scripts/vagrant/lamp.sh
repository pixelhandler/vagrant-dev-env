#!/usr/bin/env bash

# Setup Apache, MySql, PHP

# Install VM packages.
apt-packages-install   \
apache2-mpm-worker     \
apache2-suexec-custom  \
mysql-server-5.1       \
libapache2-mod-fastcgi \
php5-cgi               \
php5-gd                \
php5-mysql             \
memcached

# Allow modules for Apache.
apache-modules-enable actions rewrite fastcgi suexec

# Replace the default Apache site.
PHP=/usr/bin/php-cgi apache-sites-create 'vagrant'
apache-sites-disable default default-ssl
apache-sites-enable vagrant

# Restart Apache web service.
apache-restart

# Allow unsecured remote access to MySQL.
mysql-remote-access-allow

# Restart MySQL service for changes to take effect.
mysql-restart

