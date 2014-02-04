#!/usr/bin/env bash

#sudo add-apt-repository ppa:rethinkdb/ppa   && \
#sudo apt-get update                         && \
#sudo apt-get install rethinkdb

apt-packages-ppa 'rethinkdb/ppa'
apt-packages-update
apt-packages-install rethinkdb
