template '/etc/init.d/redis-accessEmail' do
  source 'redis-accessEmail.rb'
  owner "deploy" 
  group "www-data"
  mode 00755
end

template '/etc/init.d/sqs-accessEmail' do
  source 'sqs-accessEmail.rb'
  owner "deploy"  
  group "www-data"
  mode 00755
end

template '/etc/init.d/redis-integration' do
  source 'redis-integration.rb'
  owner "deploy"  
  group "www-data"
  mode 00755
end

template '/etc/init.d/sqs-integration' do
  source 'sqs-integration.rb'
  owner "deploy"  
  group "www-data"
  mode 00755
end

execute "workers-sqs-integration" do
  command "/etc/init.d/sqs-integration restart"
  action :run
end

execute "workers-redis-integration" do
  command "/etc/init.d/redis-integration restart"
  action :run
end

execute "workers-sqs-accessEmail" do
  command "/etc/init.d/sqs-accessEmail restart"
  action :run
end

execute "workers-redis-integration" do
  command "/etc/init.d/redis-accessEmail restart"
  action :run
end
