#!/usr/bin/env bash

# Vim config - see: https://github.com/pixelhandler/vim-config

if [ -d /home/vagrant/.vim ]
then
  echo 'vim config already setup. '
else
  git clone git://github.com/pixelhandler/vim-config.git ./.vim
  cd /home/vagrant/.vim
  git submodule init
  git submodule update
  git submodule foreach git submodule init
  git submodule foreach git submodule update
  cd /home/vagrant/.vim/bundle/command-t/
  rake make 
  mkdir /home/vagrant/.vim/_backup
  mkdir /home/vagrant/.vim/_temp
  ln -s /home/vagrant/.vim/.vimrc /home/vagrant/.vimrc
  echo 'vim config setup done. '
fi

chown -R vagrant:vagrant /home/vagrant/.vim

