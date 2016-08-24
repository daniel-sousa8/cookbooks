#
# Cookbook Name:: php
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

case node[:platform]
   
   when 'ubuntu'
 
execute 'update_ubuntu' do
  user 'root'
  command 'sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get -y dist-upgrade'
  action :run
end

execute 'add_repository_update' do
  user 'root'
  command 'sudo add-apt-repository -y ppa:ondrej/php && sudo apt-get update'
  action :run
end

execute 'install_php' do
  user 'root'
  command 'sudo apt-get install  dh-php php-common php-curl php-gd php-igbinary  php-imagick php-imap  php-mbstring  php-mcrypt  php-memcached  php-msgpack  php-mysql  php-pear  php-pgsql php-soap  php-sqlite3 php-xml  php7.0-bcmath   php7.0-cli php7.0-common   php7.0-curl php7.0-dev php7.0-fpm  php7.0-gd php7.0-imap  php7.0-intl  php7.0-json  php7.0-mbstring php7.0-mcrypt  php7.0-mysql  php7.0-opcache php7.0-pgsql  php7.0-readline php7.0-soap php7.0-sqlite3 php7.0-xml php7.0-zip pkg-php-tools -y --force-yes'
  action :run
end

service "php7.0-fpm" do
  action [ :enable, :restart ]
end

   when 'redhat', 'centos', 'amazon'


execute 'update-epel' do
  cwd Chef::Config[:file_cache_path]
  command <<-EOF
    yum -y install epel-release
    wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
    wget https://centos6.iuscommunity.org/ius-release.rpm
    rpm -Uvh ius-release*.rpm
    yum -y update
    EOF
end

execute 'install_php7_centos' do
  user 'root'
  command 'yum install php70u-debuginfo mod_php70u php70u-bcmath php70u-cli php70u-common php70u-dba php70u-dbg php70u-devel php70u-embedded php70u-enchant php70u-fpm php70u-fpm-nginx.noarch php70u-gmp php70u-imap  php70u-intl php70u-json php70u-ldap php70u-mbstring php70u-mcrypt php70u-mysqlnd php70u-odbc php70u-opcache php70u-pdo php70u-pdo-dblib php70u-pear.noarch php70u-pgsql php70u-process php70u-pspell php70u-recode php70u-snmp php70u-soap php70u-tidy php70u-xml php70u-xmlrpc  -y --force-yes'
  action :run
end

#template '/etc/php.ini' do
#  source 'php.ini'
#  owner 'root'
#  group 'root'
#  mode '0644'
#end

service "php-fpm" do
  action [ :enable, :start ]
  supports :restart => true
end

