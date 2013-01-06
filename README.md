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
9. Visit <http://precise64> or <http://precise64/phpinfo.php> to working apache vhost

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
* [Meteor Quickstart](http://docs.meteor.com/#quickstart "meteor")
* [Deployd Getting Started](http://www.deployd.com/docs/index.md "deployd")

## Build Something with Yeoman.io, deployd, or Meteor

1. If not already in the repo's root directory `cd vagrant-dev-env` (or the path you created)
2. Login to your presice64 box via ssh `vagrant ssh` (the examples below are run from the vagrant box after connecting via ssh)

* Build a HTML5 boilerplate project: `cd /vagrant/www && yeoman init quickstart`  
* Visit <http://precise64/app/> a basic [h5bp](http://html5boilerplate.com "h5bp") project is running  

**Note:** Running mongo from apps in the shared directory /vagrant may not work; however running from your /home/vagrant (`cd ~`) directory works. To keep application files in the shared directory /vagrant but run from /home/vagrant/ **use *rsync* as a workaround**. See [stackoverflow 'Problems to run examples in Meteor'](http://stackoverflow.com/questions/10103830/problems-to-run-examples-in-meteor).

Build the **meteor** example todos app  
* `cd /vagrant && meteor create --example todos`  
* `rsync -Pav /vagrant/todos/ /home/vagrant/todos/`  
* `cd /home/vagrant/todos && meteor run` *(should start on port 3000)*  
* Visit <http://precise64:3000>  

Build a **deployd** app  
* `cd /vagrant && dpd create hello`  
* `rsync -Pav /vagrant/hello/ /home/vagrant/hello/`  
* `cd /home/vagrant/hello && dpd` *(should start on port 2403)*  
* Visit <http://precise64:2403> and <http://precise64:2403/dashboard>  


