#!/usr/bin/env bash

apt-packages-repository 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' '7F0CEB10'
apt-packages-update
apt-packages-install mongodb-10gen

if [ ! -d '/data' ]; then
  sudo mkdir /data
  sudo mkdir /data/db
  sudo mkdir /data/db/journal
  sudo chown -R vagrant:vagrant /data
fi
