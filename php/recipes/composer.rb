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

unless node[:opsworks][:stack][:name] ==  'Feira-HMG', 'Feira-PRD'

template "/srv/www/#{application}/current/.env" do
  source 'env.rb'
  owner 'deploy'
  group 'www-data'
  mode '0644'
end
end
  
template "/srv/www/#{application}/current/.env" do
  source 'env-feira.rb'
  owner 'deploy'
  group 'www-data'
  mode '0644'
end

execute 'permissao_bootstrap' do
  user 'root'
  command "chmod 775 /srv/www/#{application}/current/bootstrap/ -R"
  action :run
end

execute 'permissao_storage' do
  user 'root'
  command "chmod 775 /srv/www/#{application}/current/storage/ -R"
  action :run
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
