# whenever for lackmus
env :PATH, '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
env :RAILS_ENV, :production

set :output, "#{path}/log/whenever-lackmus.log"

every 10.minutes do
  command "#{path}/utils/import-syslog-events.rb"
end

every 1.day do
  rake "lackmus:process_all"
end

