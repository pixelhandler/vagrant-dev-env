#!/usr/bin/env bash

# Vim config - see: https://github.com/pixelhandler/vim-config

VAGRANTHOME="/home/vagrant/"
VIMDIR="/home/vagrant/.vim"
echo "checking directory "$VIMDIR

if [ -d $VIMDIR ]; then echo 'vim config already setup in '$VIMDIR
else
  git clone git://github.com/pixelhandler/vim-config.git $VIMDIR
  ln -s $VIMDIR/.vimrc $VAGRANTHOME/.vimrc
  cd $VIMDIR
  mkdir _backup _temp
  git submodule init
  git submodule update
  git submodule foreach git submodule init
  git submodule foreach git submodule update
  sudo chown -R vagrant:vagrant $VIMDIR
  sudo chown vagrant:vagrant $VAGRANTHOME/.vimrc
  echo 'vim config setup in '$VIMDIR
  echo 'to use command-t with vim see: https://github.com/wincent/Command-T'
  echo 'you will need to build, like so... '
  echo '"`cd ~/.vim/bundle/command-t && sudo rake make`'
fi

