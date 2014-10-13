#
# Cookbook Name:: squid
# Recipe:: default
#
# Copyright 2014, Gareth Llewellyn
# 		  Gareth@NetworksAreMadeOfString.com
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


case node[:platform]
        when "centos"
                remote_file "/tmp/rpmforge.rpm" do
                        source "http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm"
                        mode "0644"
                        action :create_if_missing
                end

                execute "Install RPMForge" do
                        command "yum install -y /tmp/rpmforge.rpm"
                        creates "/etc/yum.repos.d/rpmforge.repo"
                        action :run
                end

        when "ubuntu"
	#??
end


installpackages  = [];
case node[:platform]
    when "ubuntu"
        installpackages = ["squid", "git","diffutils","wget"]
    when "centos"
        installpackages = ["squid", "git", "ifstat","diffutils","wget"]
end

if(installpackages.length > 0)
  installpackages.each do |pkg|
      package pkg
  end
end

#Prefixes - disabled for the moment because no support for updating yet
#cookbook_file "/etc/squid/prefixes.txt" do
#        mode "0644"
#        action :create_if_missing
#end

#The Domain whitelist (updated by the cron jobs below)
cookbook_file "/etc/squid/whitelist.txt" do
        mode "0644"
        action :create_if_missing
end

#These are the nice looking error pages that explain PacketFlagon specific squid errors
git "/etc/squid/error" do
	repository "https://github.com/RoutingPacketsIsNotACrime/SquidError.git"
	action :export
end


service "squid" do
  action [ :enable, :start ]
end

#Packet flagon settings (fairly default)
template "/etc/squid/squid.conf" do
  source "squid.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, resources(:service => "squid")
end

#The two scripts for syncing what's going on
scriptTemplates = ["updateBWStats","updateDomainACL"]

#Install each script and set up the cron
scriptTemplates.each do |script|

	template "/etc/squid/#{script}.sh" do
  		owner "root"
  		group "root"
  		mode 0744
	end

	cron "cron for #{script}" do
		minute '*'
		hour '*'
		day '*'
		mailto node[:packetflagon][:contact]
		command "/etc/squid/#{script}.sh 1>/dev/null 2>&1"
	end
end
