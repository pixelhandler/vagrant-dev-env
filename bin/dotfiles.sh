#!/bin/bash

# use like
# `vagrant ssh`
# `/vagrant/bin/bootstrap.sh`

# Or for dry run... add option -d or --dry-run
# `/vagrant/bin/bootstrap.sh -d` 
# `/vagrant/bin/bootstrap.sh --dry-run` 

# To skip prompt and force execution... add option -f or --force
# `/vagrant/bin/bootstrap.sh -f` 
# `/vagrant/bin/bootstrap.sh --force` 

# Note copy your keys id_rsa and id_rsa.pub to /dotfiles/.ssh/ 
# this will copy the keys into your vagrant box
# e.g. `cp ~/.ssh/id_rsa* /your_path_to.../dotfiles/.ssh/`

cd "$(dirname "${BASH_SOURCE}")"

function doIt() {
    if [ ! -d $HOME/.ssh ]; then
        echo "Creating $HOME/.ssh directory"
        mkdir $HOME/.ssh
    fi
    rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" --exclude "README.md" -Pav /vagrant/dotfiles/ ~
}
function dryRun() {
    echo "Dry Run..."
    rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" --exclude "README.md" -Pavn /vagrant/dotfiles/ ~
}
if [ "$1" == "--force" -o "$1" == "-f" ]; then
    doIt
elif [ "$1" == "--dry-run" -o "$1" == "-d" ]; then
    dryRun
else
    read -p "This may overwrite existing files in your /home/vagrant/ directory. Are you sure? (y/n) " -n 1
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        doIt
    fi
fi
unset doIt
unset dryRun
source ~/.bashrc
