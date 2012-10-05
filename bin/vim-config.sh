#!/usr/bin/env bash

# Vim config - see: https://github.com/pixelhandler/vim-config

if [ -d /home/vagrant/.vim ]; then echo 'vim config already setup. '
else
  mkdir /home/vagrant/.vim && cd /home/vagrant/.vim
  mkdir _backup _temp
  git clone git://github.com/pixelhandler/vim-config.git .
  git submodule init
  git submodule update
  git submodule foreach git submodule init
  git submodule foreach git submodule update
  cd bundle/command-t/
  rake make
  cd ~
  ln -s .vim/.vimrc ./.vimrc
  echo 'vim config setup done. '
fi

chown -R vagrant:vagrant /home/vagrant/.vim

