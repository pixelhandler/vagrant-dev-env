Vagrant Development Environment
===============================

Vagrant development environment provisioned with shell scripts on precise64 box

## Setup

1. Install VirtualBox (version 4.1.22 or 4.1.23 not 4.2)
2. Install Vagrant (vagrantup.com)
3. Clone repo `git clone git://github.com/pixelhandler/vagrant-dev-env.git`
4. Build box `cd vagrant-dev-env && vagrant up`
5. Add to your hosts file: `echo '192.168.50.4 precise64' >> /etc/hosts`
6. Visit <http://precise64> or <http://precise64/phpinfo.php> to working apache vhost

## Provision.sh and /bin

The precise64 box uses a shell script to provision the vagrant box. Also in the /bin/ directory are the shell scripts for installing apache, mysql, php, mongo, node.js, ruby, yeoman.io and my vim-config with a bunch of tools for an IDE.

**INFO:**  
* [Vagrant Shell Scripts](https://github.com/StanAngeloff/vagrant-shell-scripts "scripts") by StanAngeloff  
* [Boxes](http://www.vagrantbox.es "boxes")  
* [Provision with shell](http://vagrantup.com/v1/docs/provisioners/shell.html "shell")  
* [Host Only Networking](http://vagrantup.com/v1/docs/host_only_networking.html "host")  
* [Bridged Newtworking](http://vagrantup.com/v1/docs/bridged_networking.html "bridged")  
* [Install Yeoman on Linux](https://github.com/yeoman/yeoman/issues/461 "yeoman on linux")  
* [Vim-config](https://github.com/pixelhandler/vim-config "Vim config") using pathogen

