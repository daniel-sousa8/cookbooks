#
# Cookbook Name:: php
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node[:deploy].each do |application, deploy|

#case node[:platform]
 
   
package "nginx" do
  action :install
end

case node[:platform]

    when 'ubuntu'

template '/etc/nginx/sites-available/default' do
  source 'vhost.conf'
  owner "www-data" 
  group "root"
  mode 00644
  variables({  :app_name => "#{application}"})
end
    
    when 'redhat', 'centos', 'amazon'

template '/etc/nginx/sites-available/default' do
  source 'vhost.conf'
  owner "nginx" 
  group "root"
  mode 00644
  variables({  :app_name => "#{application}"})
end

service "nginx" do
  action [ :enable ]
end
end
end
