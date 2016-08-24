APP_ENV=staging
APP_DEBUG=true

API_URL=<%= node['connections']['api_url'] %>

AUTH_URL=<%= node['connections']['auth_url'] %>

APP_URL=<%= node['connections']['app_url'] %>

NOTIFICATION_URL=<%= node['connections']['notification_url'] %>

NOTIFICATION_BROADCAST=<%= node['connections']['notification_broadcast'] %>

APP_KEY=<%= node['key']['app_key'] %>

CHAT_URL=<%= node['connections']['chat_url'] %>

DB_HOST=<%= node['rds']['host'] %>
DB_DATABASE=<%= node['rds']['database'] %>

BE_API_HOST=<%= node['connections']['be_api_host'] %>

DB_USERNAME=<%= node['rds']['username'] %>
DB_PASSWORD=<%= node['rds']['password'] %>

CACHE_DRIVER=array
#SESSION_DRIVER=redis
SESSION_DRIVER=file
#QUEUE_DRIVER=sqs
QUEUE_DRIVER=sync

REDIS_HOST=<%= node['redis']['host'] %>
REDIS_PASSWORD=null
REDIS_PORT=<%= node['redis']['port'] %>

AWS_KEY=<%= node['aws']['aws_key'] %>
AWS_SECRET=<%= node['aws']['aws_secret'] %>

AVATAR_NO_PICTURE=/static/img/avatar-not-available.png

SQS_PREFIX=<%= node['connections']['sqs_prefix'] %>
SQS_REGION=sa-east-1

SOCKET_URL=<%= node['connections']['socket_url'] %>
