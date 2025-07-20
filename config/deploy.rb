# config valid for current version and patch releases of Capistrano
lock "~> 3.19.2"

set :application, "star"
set :repo_url, "git@github.com:thanhtruong1216/twinkling.git"

# Directory to deploy to on the server
set :deploy_to, "/var/www/#{fetch(:application)}"

# Shared files and directories between releases
append :linked_files, "config/master.key", "config/database.yml", "config/credentials/production.key"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "storage"

# Keep only the last release (adjust as needed)
set :keep_releases, 1

# Ruby version (using rbenv)
set :rbenv_type, :user
set :rbenv_ruby, '3.2.2'

# Yarn install options
set :yarn_flags, '--silent --no-progress'

# Set environment variables including RAILS_MASTER_KEY
set :default_env, lambda {
  master_key_path = "#{shared_path}/config/master.key"
  master_key = File.exist?(master_key_path) ? File.read(master_key_path).strip : ""
  {
    "RAILS_MASTER_KEY" => master_key,
    "NODE_OPTIONS" => "--openssl-legacy-provider"
  }
}

# Hook to restart Puma after deploy
namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'puma:restart'
  end

  after :publishing, :restart
end
