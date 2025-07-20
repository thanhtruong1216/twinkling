lock "~> 3.18.1"

set :application, "twinkling"
set :repo_url, "git@github.com:thanhtruong1216/twinkling.git"

set :deploy_to, "/var/www/star"

# Nếu bạn dùng rbenv
set :rbenv_type, :user
set :rbenv_ruby, '3.2.2'

set :pty, true
set :format, :airbrussh

# Use bundler
set :bundle_flags, '--deployment'
set :bundle_without, %w{development test}.join(' ')

append :linked_files, "config/database.yml", "config/master.key"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "storage"
