#!/usr/bin/env bash

apt-packages-ppa 'chris-lea/node.js'
apt-packages-update

apt-packages-install \
  nodejs             \
  npm

# see http://www.deployd.com
npm install deployd -g

# http://meteor.com/main see: https://github.com/meteor/meteor
curl https://install.meteor.com | /bin/sh

