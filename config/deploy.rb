# config valid for current version and patch releases of Capistrano
lock "~> 3.19.2"

set :application, "star"
set :repo_url, "git@github.com:thanhtruong1216/twinkling.git" # sửa theo repo của bạn

# Default deploy_to directory
set :deploy_to, "/var/www/#{fetch(:application)}"

# Files and directories that are shared between releases
append :linked_files, "config/master.key", "config/database.yml", "config/credentials/production.key"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "storage"

# Set RAILS_MASTER_KEY and NODE_OPTIONS at runtime
set :default_env, lambda {
  master_key_path = "#{shared_path}/config/master.key"
  master_key = File.exist?(master_key_path) ? File.read(master_key_path).strip : ""
  {
    "RAILS_MASTER_KEY" => master_key,
    "NODE_OPTIONS" => "--openssl-legacy-provider"
  }
}

# Keep last 5 releases
set :keep_releases, 1

# Ruby version (nếu bạn dùng rbenv hoặc rvm)
set :rbenv_type, :user
set :rbenv_ruby, '3.2.2'

# Optional: nếu bạn dùng Yarn/Webpacker
set :yarn_flags, '--silent --no-progress'

namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'puma:restart'
  end

  after :publishing, :restart
end
