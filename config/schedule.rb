set :output, 'log/cron.log'
job_type :bin,  "cd :path && :environment_variable=:environment bin/:task :output"

every 1.hour do
  runner 'CreateBetsWorker.perform_async'
end

every :day do
  bin "backup_db"
end
