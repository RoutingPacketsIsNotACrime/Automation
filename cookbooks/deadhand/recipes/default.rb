#
# Cookbook Name:: deadhand
# Recipe:: default
#
# Copyright 2014, Gareth Llewellyn
#
# All rights reserved - Do Not Redistribute
#

package "php-cli" do
  action :install
end

directory "/root/deadhand" do
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

directory "/root/deadhand/twitteroauth" do
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

template "/root/deadhand/deadhand.php" do
        source "deadhand.php.erb"
        mode "0644"
	variables ({
		   	:ORG_HMAC => '',
    			:ORG_EMAIL => '',
			:GANDI_API_KEY => '',
    			:GANDI_HANDLE => '',
    			:DIGITALOCEAN_CLIENTID => '',
    			:DIGITALOCEAN_APIKEY => '',
    			:DIGITALOCEAN_SSHKEY => 0,
    			:TWITTER_APIKEY => '',
    			:TWITTER_APISECRET => '',
    			:TWITTER_OAUTHTOKEN => '',
    			:TWITTER_ACCESSTOKEN => ''
	})
	action :create_if_missing
end

cron "Schedule Deadhand to run" do
	command "php /root/deadhand.php"
	minute "0"
	hour "8"
	day "0"
end

%w{OAuth twitteroauth}.each do |file|
	cookbook_file "/root/deadhand/twitteroauth/#{file}.php" do
  		action :create_if_missing
	end
end
