# whenever for lackmus
env :PATH, '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
env :RAILS_ENV, :development

every 10.minutes do
  command "/home/wob/Projects/lackmus/utils/import-syslog-events.rb"
end
