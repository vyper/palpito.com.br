set :output, 'log/cron.log'
env :PATH, ENV['PATH']

job_type :bin,  "cd :path && :environment_variable=:environment bin/:task :output"

every 1.hour do
  runner 'CreateBetsWorker.perform_async'
end

every :day do
  bin "backup_db"
  rake "api:championship:update[$(date -d '-3 day' +%Y%m%d)]"
  rake "api:championship:update[$(date -d '-2 day' +%Y%m%d)]"
  rake "api:championship:update[$(date -d '-1 day' +%Y%m%d)]]"
  rake "api:championship:update"
  rake "api:championship:update[$(date -d '+1 day' +%Y%m%d)]]"
  rake "api:championship:update[$(date -d '+2 day' +%Y%m%d)]]"
  rake "api:championship:update[$(date -d '+3 day' +%Y%m%d)]]"
end
