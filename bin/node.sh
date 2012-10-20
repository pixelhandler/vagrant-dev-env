#!/usr/bin/env bash

apt-packages-ppa 'chris-lea/node.js'
apt-packages-update

apt-packages-install \
  nodejs             \
  npm

# set node path
echo 'if [ -d "/usr/lib/node_modules" ]; then NODE_PATH="/usr/lib/node_modules"; fi' >> ~/.profile

# see http://www.deployd.com
npm install deployd -g

# http://meteor.com/main see: https://github.com/meteor/meteor
curl https://install.meteor.com | /bin/sh

# install mocha test framework
npm install -g mocha

# install assertion libraries
npm install -g expect.js
npm install -g should
npm install -g chai

