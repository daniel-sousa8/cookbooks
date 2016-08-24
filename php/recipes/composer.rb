# Baixando e instalando composer 
execute 'add_repository_update' do
  Chef::Log.info("dd-apt-repository apt-get update")
  user 'root'
  command 'curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer'
  action :run
end

# 
execute 'add_repository_update' do
  Chef::Log.info("dd-apt-repository apt-get update")
  user 'root'
  command 'cd /srv/www/auth/current && composer install'
  action :run
end


# Gerando o .env valores no CUSTOM JSON
template '/srv/www/auth/current/.env' do
  source 'env.rb'
  owner 'deploy'
  group 'www-data'
  mode '0644'
end

execute 'permissao_bootstrap' do
  Chef::Log.info("permissao bootstrap")
  user 'root'
  command 'chmod 775 /srv/www/auth/current/bootstrap/ -R'
  action :run
end


execute 'permissao_bootstrap' do
  Chef::Log.info("permissao bootstrap")
  user 'root'
  command 'chmod 777 /srv/www/auth/current/storage/ -R'
  action :run
end

#php artisan kem:generate
