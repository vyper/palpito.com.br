rails_env   = ENV['RAILS_ENV'] || 'production'
application = 'bolao.papodeboleiro.com'
base_path   = "/var/www/#{application}"
worker_processes 4
working_directory "#{base_path}/current"
listen "#{base_path}/shared/tmp/sockets/unicorn.#{application}.sock", backlog: 64
timeout 30

pid "#{base_path}/shared/tmp/pids/unicorn.pid"
stderr_path "#{base_path}/shared/log/unicorn.stderr.log"
stdout_path "#{base_path}/shared/log/unicorn.stdout.log"

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

check_client_connection false

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
