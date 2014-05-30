server 'papodeboleiro.com', user: 'root', roles: %w{web app db}

set :rails_env, :production

set :ssh_options, forward_agent: true
