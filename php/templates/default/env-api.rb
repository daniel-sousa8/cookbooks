APP_ENV=local
APP_DEBUG=true

APP_URL=http://ec2-52-67-62-90.sa-east-1.compute.amazonaws.com

FAIR_URL=http://ec2-52-67-20-70.sa-east-1.compute.amazonaws.com

APP_KEY=base64:ep1kMMJ+AAF4tQcOZEgFgBtq4Menu0TB5IKApCIvXeo=

DB_HOST=<%= node['rds]['host'] %>
DB_DATABASE=<%= node['rds]['database'] %>
DB_USERNAME=<%= node['rds]['username'] %>
DB_PASSWORD=<%= node['rds]['password'] %>

CACHE_DRIVER=array
#SESSION_DRIVER=redis
SESSION_DRIVER=file
QUEUE_DRIVER=sync
#QUEUE_DRIVER=redis

#REDIS_HOST=redis.7n3jwl.0001.sae1.cache.amazonaws.com
REDIS_HOST=<%= node['redis]['host'] %>
REDIS_PASSWORD=null
REDIS_PORT=<%= node['redis']['port'] %>
