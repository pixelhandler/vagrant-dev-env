#!/usr/bin/env bash

DOTFILES='/vagrant/dotfiles' 

if [ ! -f $HOME/.ackrc ];
then
    echo "Copying .ackrc"
    cp $DOTFILES/.ackrc $HOME/.ackrc
fi

if [ ! -f $HOME/.bash_profile ];
then
    echo "Copying .bash_profile"
    cp $DOTFILES/.bash_profile $HOME/.bash_profile
fi

if [ ! -f $HOME/.bashrc ];
then
    echo "Copying .bash_profile"
    cp $DOTFILES/.bashrc $HOME/.bashrc
fi

if [ ! -f $HOME/.gitconfig ];
then
    echo "Copying .gitconfig"
    cp $DOTFILES/.gitconfig $HOME/.gitconfig
fi

if [ ! -f $HOME/.jshintrc ];
then
    echo "Copying .jshintrc"
    cp $DOTFILES/.jshintrc $HOME/.jshintrc
fi

if [ ! -f $HOME/.jslintrc ];
then
    echo "Copying .jslintrc"
    cp $DOTFILES/.jslintrc $HOME/.jslintrc
fi

if [ ! -f $HOME/.my.cnf ];
then
    echo "Copying .ackrc"
    cp $DOTFILES/.my.cnf $HOME/.my.cnf
fi

if [ ! -d $HOME/.ssh ];
then
    echo "Creating $HOME/.ssh directory"
    mkdir $HOME/.ssh
fi

if [ ! -f $HOME/.ssh/config ];
then
    echo "Copying .ssh/config"
    cp $DOTFILES/.ssh/config $HOME/.ssh/config
fi