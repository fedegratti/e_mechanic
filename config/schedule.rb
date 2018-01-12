set :output, "log/cron_log.log"
#set :environment, "development"

every :day, :at => '10:00am' do
  rake 'emechanic:backup_db'
end
