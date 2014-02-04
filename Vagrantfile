require 'erb'

Vagrant.require_version ">= 1.4.3"

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.boot_timeout = 300 #default

  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.network 'public_network', :bridge => 'en1: Wi-Fi (AirPort)'
  # use `ifconfig` to find ip after `vagrant ssh` or use private:
  # config.vm.network "private_network", ip: "192.168.50.4"

  config.ssh.forward_agent = true

  config.vm.provider 'virtualbox' do |vb|
    vb.customize([
      'setextradata',
      :id,
      'VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-code',
      '1'
    ])
  end

  # Enable provisioning through a shell script.
  config.vm.provision :shell do |shell|
    relative     = ''
    script       = 'provision.sh'
    shell.inline = ERB.new("<% def import(file); File.read('#{relative}' + file); end %>" + File.read("#{relative}#{script}")).result
  end

end

