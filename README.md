Vagrant Development Environment
===============================

Vagrant development environment provisioned with shell scripts on a (linux/ubuntu) precise64 box

## Setup

1. Install VirtualBox (version 4.1.22 or 4.1.23 not 4.2)
2. Install Vagrant (vagrantup.com)
3. Clone repo `git clone git://github.com/pixelhandler/vagrant-dev-env.git`
4. Build box `cd vagrant-dev-env`
5. Add submodule `git submodule init`
6. Update *vagrant-shell-scripts* submodule `git submodule update`
7. Fire up your box `vagrant up`
8. Add to your hosts file: `echo '192.168.50.4 precise64' >> /etc/hosts`

(If bin/lamp.sh is incuded in provision script)
Visit <http://precise64> or <http://precise64/phpinfo.php> to working apache vhost

## Provision.sh and /bin


The precise64 box uses a shell script to provision the vagrant box. Also in the /bin/ directory are the shell scripts for installing apache, mysql, php, mongo, node.js, ruby, yeoman.io and my vim-config with a bunch of tools for an IDE.

**INFO:**  
* Using v2 configuration for Vagrantfile
* [Vagrant Shell Scripts](https://github.com/StanAngeloff/vagrant-shell-scripts "scripts") by StanAngeloff  
* [Boxes](http://www.vagrantbox.es "boxes")  
* [Vim-config](https://github.com/pixelhandler/vim-config "Vim config") using pathogen

## Build Something

1. If not already in the repo's root directory `cd vagrant-dev-env` (or the path you created)
2. Login to your presice64 box via ssh `vagrant ssh` (the examples below are run from the vagrant box after connecting via ssh)
