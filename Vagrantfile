# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure('2') do |config|
  config.vm.box      = 'ubuntu/trusty64'
  config.vm.hostname = 'dchousing-dev-box'

  config.vm.network :forwarded_port, guest: 3000, host: 3000

  # So that we start in /vagrant when logging in
  config.vm.provision "shell", path: "puppet/manifests/cdVagrant.sh"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = 'puppet/manifests'
    puppet.module_path    = 'puppet/modules'
  end
end
