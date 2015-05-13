#
# Cookbook Name:: tor
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
        installpackages = ["tor"]
    when "centos"
        installpackages = ["tor","iptables","iptables-ipv6"]
end

if(installpackages.length > 0)
  installpackages.each do |pkg|
      package pkg
  end
end

service "tor" do
  action [ :enable, :nothing ]
end

TorDomain = "packetflagon.is"
Contact = "0xDE731050 Gareth Llewellyn <gareth@networksaremadeofstring.com>"

if node.chef_environment == "BrassHornCommunications"
	TorDomain = "BrassHornCommunications.uk"
	Contact = "0x6F6D60C1 Security Dept <hello@brasshorncommunications.uk>"
end

FingerPrints = ""

template "/etc/tor/torrc" do
  source "torrc.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :reload, resources(:service => "tor")
  variables ({
	:torDomain => TorDomain,
	:contact => Contact
  })
end


fingerprint=`tor --list-fingerprint | egrep "[A-F0-9]{32}" | awk '{print $13}' | sed "s/'//g"`
node.default[:tor_fingerprint] = fingerprint

service "iptables" do
  action [ :enable, :nothing ]
end

service "ip6tables" do
  action [ :enable, :nothing ]
end

template "/etc/sysconfig/iptables" do
  source "iptables.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, resources(:service => "iptables")
end

template "/etc/sysconfig/ip6tables" do
  source "ip6tables.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, resources(:service => "ip6tables")
end
