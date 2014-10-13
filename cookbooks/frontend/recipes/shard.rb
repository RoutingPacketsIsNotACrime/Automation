#
# Cookbook Name:: frontend
# Recipe:: shard
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
#

#Clone the PacketFlagon software and populate the config template
include_recipe "frontend::default"

directory "/var/www/#{node[:packetflagon][:fqdn]}" do
  owner 'root'
  group 'pfadmin'
  mode '0664'
  action :create
end

execute "Clone ProxyShard repo" do
	command "git clone https://github.com/RoutingPacketsIsNotACrime/PacketFlagon.git /var/www/#{node[:packetflagon][:fqdn]}"
       	creates "/var/www/#{node[:packetflagon][:fqdn]}/index.php"
        action :run
end

directory "/var/www/#{node[:packetflagon][:fqdn]}/libs" do
  owner 'root'
  group 'pfadmin'
  mode '0644'
  action :create
end

template "/var/www/#{node[:packetflagon][:fqdn]}/libs/config.php" do
	source "config.php.erb"
	mode "0644"
end

template "/etc/httpd/conf.d/#{node[:packetflagon][:fqdn]}.conf" do
        source "website.conf.erb"
        mode "0644"
	notifies :restart, resources(:service => "apache2")
end
