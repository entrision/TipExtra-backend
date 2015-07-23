set :user, 'tipextra'
set :stage, :production
set :rails_env, :production
set :branch, 'master'

server '104.236.79.250', roles: [:app, :web, :db], user: 'tipextra'

set :ssh_options, {
  forward_agent: true,
  port: 22
}

