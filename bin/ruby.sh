#!/usr/bin/env bash

#apt-packages install \
  #ruby               \
  #rubygems           \
  #rake

apt-packages-install \
  ruby1.9.1          \
  ruby1.9.1-dev      \
  rubygems1.9.1

alternatives-ruby-install 1.9.1
ruby-gems-install pkg-config
ruby-gems-install sass
ruby-gems-install compass

