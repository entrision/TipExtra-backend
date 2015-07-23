lock '3.4.0'

set :rvm_ruby_version, '2.2.1@tipextra'

set :format, :pretty
set :log_level, :debug
set :pty, true

set :application, 'tipextra'
set :repo_url,    'git@github.com:entrision/TipExtra-backend.git'
set :deploy_to,   '/var/www/tipextra'
set :deploy_via,  :remote_cache
set :branch,      'master'

set :linked_files, %w{config/database.yml config/unicorn.rb}
set :linked_dirs,  %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :unicorn_command, "bundle exec unicorn"
set :unicorn_config, "#{current_path}/config/unicorn.rb"
set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"

namespace :deploy do

  task :start do
    on roles(:app) do
      execute "sudo start tipextra"
    end
  end

  task :stop do
    on roles(:app) do
      execute "sudo stop tipextra"
    end
  end

  task :graceful_stop do
    on roles(:app) do
      execute "sudo stop tipextra"
    end
  end

  task :reload do
    on roles(:app) do
      execute "sudo restart tipextra"
    end
  end

  task :restart do
    on roles(:app) do
      invoke "deploy:reload"
    end
  end

  after :publishing, :restart
end
