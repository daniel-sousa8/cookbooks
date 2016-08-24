#
# Cookbook Name:: php
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute 'update_ubuntu' do
  Chef::Log.info("update_system_ubuntu")
  user 'root'
  command 'sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get -y dist-upgrade'
  action :run
end


execute 'add_repository_update' do
  Chef::Log.info("dd-apt-repository apt-get update")
  user 'root'
  command 'sudo add-apt-repository -y ppa:ondrej/php && sudo apt-get update'
  action :run
end


execute 'install_php' do
  Chef::Log.info("installing packages")
  user 'root'
  command 'sudo apt-get install  dh-php php-common php-curl php-gd php-igbinary  php-imagick php-imap  php-mbstring  php-mcrypt  php-memcached  php-msgpack  php-mysql  php-pear  php-pgsql php-soap  php-sqlite3 php-xml  php7.0-bcmath   php7.0-cli php7.0-common   php7.0-curl php7.0-dev php7.0-fpm  php7.0-gd php7.0-imap  php7.0-intl  php7.0-json  php7.0-mbstring php7.0-mcrypt  php7.0-mysql  php7.0-opcache php7.0-pgsql  php7.0-readline php7.0-soap php7.0-sqlite3 php7.0-xml php7.0-zip pkg-php-tools -y --force-yes'
  action :run
end

#template '/etc/zabbix/zabbix_agentd.conf' do
#  source 'zabbix_agentd.rb'
#  owner 'zabbix'
#  group 'zabbix'
#  mode '0644'
#end

# service php7.0-fpm restart
service "php7.0-fpm" do
  action [ :enable, :restart ]
end
