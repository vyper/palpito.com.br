# config valid only for Capistrano 3.1
lock '3.2.1'

set :rollbar_token, ENV['ROLLBAR_TOKEN']
set :rollbar_env, Proc.new { fetch :stage }
set :rollbar_role, Proc.new { :app }

set :application, 'bolao.papodeboleiro.com'
set :repo_url, 'git@github.com:mcorp/bolao.git'

set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      within release_path do
        with rails_env: fetch(:rails_env), bundle_gemfile: fetch(:bundle_gemfile) do
          execute :pkill, '-f', 'unicorn_rails'
          execute :bundle, 'exec', 'unicorn_rails', '-c', 'config/unicorn.rb', '-E', fetch(:rails_env), '-D'
        end
      end
    end
  end

end
