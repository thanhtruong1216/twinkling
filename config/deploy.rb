lock "~> 3.19.2"

set :application, "star"
set :repo_url, "git@github.com:thanhtruong1216/twinkling.git"
set :branch, "master"
set :deploy_to, "/var/www/star"
set :user, "ubuntu"

# Link shared files and directories
set :linked_files, fetch(:linked_files, []).push(
  "config/database.yml",
  "config/master.key"
)

set :linked_dirs, fetch(:linked_dirs, []).push(
  "log",
  "tmp/pids",
  "tmp/cache",
  "tmp/sockets",
  "vendor/bundle",
  ".bundle",
  "public/system",
  "public/uploads",
  "storage"
)

# Set environment variables (do not use File.read here to avoid early evaluation)
set :default_env, {
  "RAILS_MASTER_KEY" => ENV["RAILS_MASTER_KEY"],
  "NODE_OPTIONS" => "--openssl-legacy-provider"
}

namespace :deploy do
  desc "Check that master.key is in shared path"
  task :check_master_key do
    on roles(:app) do
      unless test("[ -f #{shared_path}/config/master.key ]")
        error "❌ master.key is missing in #{shared_path}/config/"
        exit 1
      end
    end
  end

  before :starting, :check_master_key

  desc "Restart application"
  task :restart do
    invoke "puma:restart"
  end

  after :publishing, :restart
end
