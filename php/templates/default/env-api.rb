APP_ENV=local
APP_DEBUG=true

APP_URL=<%= node['elb']['app_url'] %>

FAIR_URL=<%= node['fair_url']['url'] %>

APP_KEY=<%= node['key']['app_key'] %>

DB_HOST=<%= node['rds']['host'] %>
DB_DATABASE=<%= node['rds']['database'] %>
DB_USERNAME=<%= node['rds']['username'] %>
DB_PASSWORD=<%= node['rds']['password'] %>

CACHE_DRIVER=array
#SESSION_DRIVER=redis
SESSION_DRIVER=file
QUEUE_DRIVER=sync
#QUEUE_DRIVER=redis

REDIS_HOST=<%= node['redis']['host'] %>
REDIS_PASSWORD=null
REDIS_PORT=<%= node['redis']['port'] %>
