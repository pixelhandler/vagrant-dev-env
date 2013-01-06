#!/usr/bin/env bash

apt-packages-install \
  ruby1.9.1          \
  ruby1.9.1-dev      \
  ruby1.8-dev        \
  rubygems1.9.1      \
  rake               \
  rbenv

#curl -L get.rvm.io | bash -s stable --auto
#curl -L https://get.rvm.io | bash -s -- --auto-dotfiles

alternatives-ruby-install 1.9.1
ruby-gems-install pkg-config
ruby-gems-install sass
ruby-gems-install compass
ruby-gems-install bundler
ruby-gems-install railsless-deploy
ruby-gems-install capistrano

