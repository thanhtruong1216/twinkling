# config valid for current version and patch releases of Capistrano
lock "~> 3.19.2"

set :application, "twinkling"
set :repo_url, "git@github.com:thanhtruong1216/twinkling.git"

set :deploy_to, "/var/www/star"

# RBENV settings
set :rbenv_type, :user
set :rbenv_ruby, '3.2.2'
set :rbenv_prefix, "#{fetch(:rbenv_path, '$HOME/.rbenv')}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

namespace :master_key do
  desc "Load master key content from server"
  task :load do
    on roles(:app) do
      master_key = capture(:cat, "#{shared_path}/config/master.key").strip
      set :rails_master_key, master_key
    end
  end
end

before 'deploy:starting', 'master_key:load'

append :linked_files, 'config/database.yml'

set :default_env, -> {
  {
    'RAILS_MASTER_KEY' => fetch(:rails_master_key),
    'NODE_OPTIONS' => '--openssl-legacy-provider'
  }
}

# Bundler settings
set :bundle_flags, '--deployment'
set :bundle_without, %w{development test}.join(' ')

# Capistrano options
set :format, :airbrussh
set :pty, true

# Files & directories to symlink in each release
append :linked_files, "config/database.yml", "config/master.key"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "storage"

# Keep last 5 releases
set :keep_releases, 1

# Optional: If using Passenger, uncomment below
# require 'capistrano/passenger'
