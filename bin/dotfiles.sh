#!/usr/bin/env bash

DOTFILES='/vagrant/dotfiles' 

if [ ! -d $HOME/.ssh ];
then
    echo "Creating $HOME/.ssh directory"
    mkdir $HOME/.ssh

    echo "Copying dotfiles/.ssh/config"
    cp $DOTFILES/.ssh/config $HOME/.ssh/config

	# Copy contents of dotfiles/.bashrc to ~/.bashrc
    echo "Copying dotfiles/.bashrc into ~/.bashrc"
    cat $DOTFILES/.bashrc >> $HOME/.bashrc
fi

# should not need this precise64 box provisions with a .profile which includes .bashrc
# if [ ! -f $HOME/.bash_profile ];
# then
#     echo "Copying dotfiles/.bash_profile"
#     cp $DOTFILES/.bash_profile $HOME/.bash_profile
# fi

if [ ! -f $HOME/.ackrc ];
then
    echo "Copying dotfiles/.ackrc"
    cp $DOTFILES/.ackrc $HOME/.ackrc
fi

if [ ! -f $HOME/.gitconfig ];
then
    echo "Copying dotfiles/.gitconfig"
    cp $DOTFILES/.gitconfig $HOME/.gitconfig
fi

if [ ! -f $HOME/.jshintrc ];
then
    echo "Copying dotfiles/.jshintrc"
    cp $DOTFILES/.jshintrc $HOME/.jshintrc
fi

if [ ! -f $HOME/.jslintrc ];
then
    echo "Copying dotfiles/.jslintrc"
    cp $DOTFILES/.jslintrc $HOME/.jslintrc
fi

if [ ! -f $HOME/.my.cnf ];
then
    echo "Copying dotfiles/.my.cnf"
    cp $DOTFILES/.my.cnf $HOME/.my.cnf
fi