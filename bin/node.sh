#!/usr/bin/env bash

apt-packages-ppa 'chris-lea/node.js'
apt-packages-update

apt-packages-install \
  nodejs             \
  npm

