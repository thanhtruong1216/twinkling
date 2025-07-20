lock "~> 3.19.2"

set :application, "star"
set :repo_url, "git@github.com:thanhtruong1216/twinkling.git"
set :branch, "master"
set :deploy_to, "/var/www/star"
set :user, "deploy"

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

# Set RAILS_MASTER_KEY globally for all deploy tasks
set :default_env, fetch(:default_env, {}).merge(
  "RAILS_MASTER_KEY" => File.read("#{shared_path}/config/master.key").strip,
  "NODE_OPTIONS" => "--openssl-legacy-provider"
)

# Clear precompile if not needed
Rake::Task["deploy:assets:precompile"].clear_actions

# Optional: Check master.key exists in release_path before starting
namespace :deploy do
  before :starting, :check_master_key do
    on roles(:app) do
      unless test("[ -f #{release_path}/config/master.key ]")
        error "❌ master.key missing in release path!"
        exit 1
      end
    end
  end

  desc "Restart Puma"
  task :restart do
    invoke "puma:restart"
  end

  after :publishing, :restart
end
