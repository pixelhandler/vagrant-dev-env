#!/usr/bin/env bash

apt-packages-repository 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' '7F0CEB10'
apt-packages-update
apt-packages-install mongodb-10gen

