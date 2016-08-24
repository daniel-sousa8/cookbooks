node[:deploy].each do |application, deploy|
  
# Baixando composer 
execute 'add_repository_update' do
  user 'root'
  command 'curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer'
  action :run
end

# Install composer
execute 'install_composer' do
  user 'root'
  command "cd /srv/www/#{application}/current && composer install"
  action :run
end

template "/srv/www/#{application}/current/.env" do
  source 'env.rb'
  owner 'deploy'
  group 'www-data'
  mode '0644'
end

directory "/srv/www/#{application}/current/bootstrap" do
  owner 'deploy'
  group 'www-data'
  mode '0775'
end

directory "/srv/www/#{application}/current/storage" do
  owner 'deploy'
  group 'www-data'
  mode '0777'
end

file "/srv/www/#{application}/current/storage/logs/laravel.log" do
  mode '0777'
  owner 'deploy'
  group 'www-data'
end

service "nginx" do
  action :restart
end
end
