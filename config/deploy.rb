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
