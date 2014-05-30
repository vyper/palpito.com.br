server 'papodeboleiro.com', user: 'root', roles: %w{web app db}

set :ssh_options, forward_agent: true
