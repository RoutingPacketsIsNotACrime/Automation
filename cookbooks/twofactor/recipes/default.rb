#
# Cookbook Name:: twofactor
# Recipe:: default
#
# Copyright 2014, Gareth Llewellyn
#                 Gareth@NetworksAreMadeOfString.com
#
#
# This program is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License
# for more details.
#
# You should have received a copy of the GNU General Public License along with
# this program. If not, see <http://www.gnu.org/licenses/>

#
# RUNNING THIS COOKBOOK WITHOUT HAVING A USER CONFIGURED WITH AN SSH PUBLIC KEY AND YUBIKEY TOKEN WILL LOCK YOU OUT!!!!!
#

case node[:platform]
	when "centos"
		remote_file "/tmp/epel.rpm" do
        		source "http://www.mirrorservice.org/sites/dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm"
        		mode "0644"
        		checksum "e5ed9ecf22d0c4279e92075a64c757ad2b38049bcf5c16c4f2b75d5f6860dc0d"
        		action :create_if_missing
	    	end

		execute "Install EPEL" do
        		command "yum install -y /tmp/epel.rpm"
        		creates "/etc/yum.repos.d/epel.repo"
        		action :run
    		end

	when "ubuntu"
		#??

end

installpackages  = [];
case node[:platform]
    when "ubuntu"
        installpackages = ["pam_yubico","libyubikey", "sudo"]
    when "centos"
        installpackages = ["pam_yubico","libyubikey", "sudo"]
end

if(installpackages.length > 0)
  installpackages.each do |pkg|
      package pkg
  end
end

#sudo
cookbook_file "/etc/pam.d/sudo" do
	mode "0644"
        action :create
end

cookbook_file "/etc/sudoers" do
	mode "0440"
	action :create 
end


#ssh
cookbook_file "/etc/pam.d/sshd" do
        mode "0644"
        action :create
end

case node[:platform]
    when "ubuntu"
        servicename = "ssh"
    when "centos"
        servicename = "sshd"
end

service "#{servicename}" do
        supports :restart => true, :reload => true
        action :enable
end


cookbook_file "/etc/ssh/sshd_config" do
	mode "0644"
	action :create
	notifies :restart, resources(:service => "#{servicename}")
end

