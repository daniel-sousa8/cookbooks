node[:deploy].each do |application, deploy|

template "/var/spool/cron/crontabs/deploy" do
  source "crontab_api.rb"
  mode "0660"
  group "www-data"
  owner "deploy"
  variables({ :app_name => "#{application}"})
end
end
