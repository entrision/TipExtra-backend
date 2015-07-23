set :user, 'tipextra'
set :stage, :staging
set :rails_env, :staging
set :branch, 'master'

server '104.236.73.241', roles: [:app, :web, :db], user: 'tipextra'

set :ssh_options, {
  forward_agent: true,
  port: 22
}
