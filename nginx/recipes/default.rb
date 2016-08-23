#
# Cookbook Name:: php
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "nginx" do
  action :install
end

template '/etc/nginx/sites-available/default' do
  source 'vhost.conf'
  owner "nginx" 
  group "nginx"
  mode 00644
end

template '/usr/share/nginx/html/' do
  source 'index.php'
  owner "nginx"
  group "nginx"
  mode 00644
end


service "nginx" do
  action [ :enable ]
end
