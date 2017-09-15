Vagrant.configure(2) do |config|
  config.vm.define :druid do |druid|
    druid.vm.network "forwarded_port", guest: 8090, host: 8090
    druid.vm.network "forwarded_port", guest: 8081, host: 8081
    druid.vm.network "forwarded_port", guest: 8082, host: 8082
    druid.vm.network "forwarded_port", guest: 1088, host: 1088
    druid.vm.network "forwarded_port", guest: 8200, host: 8200
    druid.vm.network "private_network", ip: "192.168.50.4"
    druid.vm.box = "ubuntu/trusty64"
    druid.vm.provider :virtualbox do |v|
        v.customize ["modifyvm", :id, "--memory", "8192"]
        v.customize ["modifyvm", :id, "--cpus", "2"] # druid overlord requires multi-core machine
        v.customize ["modifyvm", :id, "--ioapic", "on"]
    end
    druid.vm.synced_folder ".", "/vagrant"
    druid.vm.provision "shell" do |s|
      s.path = "install.sh"
      s.privileged = true
    end
  end
end
