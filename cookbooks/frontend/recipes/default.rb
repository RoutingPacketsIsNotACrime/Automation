#
# Cookbook Name:: frontend
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

installpackages  = [];
case node[:platform]
    when "ubuntu"
        installpackages = ["php5", "httpd"]
    when "centos"
        installpackages = ["php-cli","httpd", "mod_ssl","php","git"]
end

if(installpackages.length > 0)
  installpackages.each do |pkg|
      package pkg
  end
end

service "apache2" do
	case node[:platform]
	when "centos","redhat","fedora","suse"
		service_name "httpd"
		restart_command "/sbin/service httpd restart && sleep 1"
		reload_command "/sbin/service httpd reload && sleep 1"
	when "debian","ubuntu"
		service_name "apache2"
		restart_command "/usr/sbin/invoke-rc.d apache2 restart && sleep 1"
		reload_command "/usr/sbin/invoke-rc.d apache2 reload && sleep 1"
	when "arch"
		service_name "httpd"
	end
	supports value_for_platform(
		"debian" => { "4.0" => [ :restart, :reload ], "default" => [ :restart, :reload, :status ] },
		"ubuntu" => { "default" => [ :restart, :reload, :status ] },
		"centos" => { "default" => [ :restart, :reload, :status ] },
		"redhat" => { "default" => [ :restart, :reload, :status ] },
		"fedora" => { "default" => [ :restart, :reload, :status ] },
		"arch" => { "default" => [ :restart, :reload, :status ] },
		"default" => { "default" => [:restart, :reload ] }
	)
	action :enable
end
