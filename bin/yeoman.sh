#!/usr/bin/env bash


# Install Yeoman and dependencies 
# Use `curl -L get.yeoman.io | bash` to check dependencies

# See: 
# http://yeoman.io/
# https://github.com/yeoman/yeoman/issues/461
# https://github.com/yeoman/yeoman/wiki/Manual-Install

apt-packages-install \
  libssl-dev         \
  libfontconfig      \
  libjpeg-progs      \
  optipng


# Compass - see: http://compass-style.org/install/
if [ type compass >/dev/null 2>&1 ]
then
  sudo gem install compass
fi

# PhantomJS - see: http://phantomjs.org/download.html & http://phantomjs.org/build.html
# 64-bit - http://phantomjs.googlecode.com/files/phantomjs-1.7.0-linux-x86_64.tar.bz2
#          http://phantomjs.googlecode.com/files/phantomjs-1.8.0-linux-x86_64.tar.bz2
if [ -d /usr/local/src/phantomjs-1.8.0-linux-x86_64 ]
then
  echo 'We have the src for phantomjs. '
else 
  cd /usr/local/src
  curl -L http://phantomjs.googlecode.com/files/phantomjs-1.8.0-linux-x86_64.tar.bz2 | sudo tar jx
  echo 'The phantomjs src us downloaded. '
fi

if [ -L /usr/local/bin/phantomjs ]
then
  echo 'We have a symbolic link for phantomjs. '
else 
  echo 'Create a symbolic link for phantomjs. '
  sudo ln -s /usr/local/src/phantomjs-1.8.0-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs
fi

# Install Yeoman (node package)
# if [ command -v yeoman >/dev/null 2>&1 ]
if [ -x /usr/bin/yeoman ]
then
  echo 'Yeoman is installed. '
else
  echo 'Install yeoman. '
  sudo npm install -g yeoman
fi

