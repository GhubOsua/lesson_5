# -*- mode: ruby -*-
# vim: set ft=ruby :
Virtual = ENV['Virtual']
ENV["LC_ALL"] = "en_US.UTF-8"

MACHINES1 = {
  :lesson5nfsserver=> {
        :box_name => "centos/7",
        :box_version => "1804.02",
        :ip_addr => '192.168.11.101',
    :cpus => 2,
    :disks => {
        :sata1 => {
            :dfile => Virtual+'/lesson5/sata1_nfs_server.vdi',
            :size => 1024, # Megabytes
            :port => 1
        },
        :sata2 => {
            :dfile => Virtual+'/lesson5/sata2_nfs_server.vdi',
            :size => 1024, # Megabytes
            :port => 2
        }
     }
   },
}
MACHINES2 = {
 :lesson5nfsclient=> {
        :box_name => "centos/7",
        :box_version => "1804.02",
        :ip_addr => '192.168.11.102',
    :cpus => 2,
    :disks => {
        :sata1 => {
            :dfile => Virtual+'/lesson5/sata1_nfs_client.vdi',
            :size => 1024, # Megabytes
            :port => 1
              }
            }
	},
 }

Vagrant.configure("2") do |config|

    config.vm.box_version = "1804.02"

    MACHINES1.each do |boxname, boxconfig|
  
        config.vm.define boxname do |box|
  
            box.vm.box = boxconfig[:box_name]
            box.vm.host_name = boxname.to_s
  
            #box.vm.network "forwarded_port", guest: 3260, host: 3260+offset
  
            box.vm.network "private_network", ip: boxconfig[:ip_addr]
  
            box.vm.provider :virtualbox do |vb|
                    vb.customize ["modifyvm", :id, "--memory", "2048"]
		    vb.cpus = boxconfig[:cpus]
                    needsController = false
            boxconfig[:disks].each do |dname, dconf|
                unless File.exist?(dconf[:dfile])
                  vb.customize ['createhd', '--filename', dconf[:dfile], '--variant', 'Fixed', '--size', dconf[:size]]
                                  needsController =  true
                            end
  
            end
                    if needsController == true
                       vb.customize ["storagectl", :id, "--name", "SATA", "--add", "sata" ]
                       boxconfig[:disks].each do |dname, dconf|
                           vb.customize ['storageattach', :id,  '--storagectl', 'SATA', '--port', dconf[:port], '--device', 0, '--type', 'hdd', '--medium', dconf[:dfile]]
                       end
                    end
            end
	config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
	config.vm.provision "shell", path: "script_serv.sh"	  
        #box.vm.provision "shell", inline: <<-SHELL
            #mkdir -p ~root/.ssh
            #cp ~vagrant/.ssh/auth* ~root/.ssh
            #yum install -y mdadm smartmontools hdparm gdisk
          #SHELL
  
        end
    end
  

    MACHINES2.each do |boxname, boxconfig|
  
        config.vm.define boxname do |box|
  
            box.vm.box = boxconfig[:box_name]
            box.vm.host_name = boxname.to_s
  
            #box.vm.network "forwarded_port", guest: 3260, host: 3260+offset
  
            box.vm.network "private_network", ip: boxconfig[:ip_addr]
  
            box.vm.provider :virtualbox do |vb|
                    vb.customize ["modifyvm", :id, "--memory", "2048"]
		    vb.cpus = boxconfig[:cpus]
                    needsController = false
            boxconfig[:disks].each do |dname, dconf|
                unless File.exist?(dconf[:dfile])
                  vb.customize ['createhd', '--filename', dconf[:dfile], '--variant', 'Fixed', '--size', dconf[:size]]
                                  needsController =  true
                            end
  
            end
                    if needsController == true
                       vb.customize ["storagectl", :id, "--name", "SATA", "--add", "sata" ]
                       boxconfig[:disks].each do |dname, dconf|
                           vb.customize ['storageattach', :id,  '--storagectl', 'SATA', '--port', dconf[:port], '--device', 0, '--type', 'hdd', '--medium', dconf[:dfile]]
                       end
                    end
            end
	config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
	config.vm.provision "shell", path: "script_client.sh"		
        #box.vm.provision "shell", inline: <<-SHELL
            #mkdir -p ~root/.ssh
            #cp ~vagrant/.ssh/auth* ~root/.ssh
            #yum install -y mdadm smartmontools hdparm gdisk
          #SHELL
  
        end
    end

end
  
