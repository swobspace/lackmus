# config valid only for current version of Capistrano
lock '3.6.1'

config = YAML.load_file('config/deploy-config.yml') || {}

set :application, 'lackmus'
set :repo_url, config['repo_url']
set :relative_url_root, config['relative_url_root'] || '/'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
ask :branch, :master

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'
set :deploy_to, config['deploy_to']

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, 'config/database.yml', 'config/secrets.yml'
# append :linked_files, 'config/database.yml', 'config/lackmus.yml', 'config/secrets.yml'
set :linked_files, %w{config/database.yml config/lackmus.yml config/secrets.yml}

# Default value for linked_dirs is []
# append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

append :linked_dirs, 'bin', 'log', 'files', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :default_env, { rails_relative_url_root: fetch(:relative_url_root) }

set :shell, "bash -l"

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do
  desc "Check that we can access everything"
  task :check_write_permissions do
    on roles(:all) do |host|
      if test("[ -w #{fetch(:deploy_to)} ]")
        info "#{fetch(:deploy_to)} is writable on #{host}"
      else
        error "#{fetch(:deploy_to)} is not writable on #{host}"
      end
    end
  end
end 

namespace :bower do
  desc 'Install bower'
  task :install do
    on roles(:web) do
      within release_path do
        execute :rake, 'bower:install CI=true'
      end
    end
  end
end

before 'deploy:compile_assets', 'bower:install'

