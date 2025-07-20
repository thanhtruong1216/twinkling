# frozen_string_literal: true

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

# ✅ Không chạy precompile (vì assets đã được build sẵn)
Rake::Task["deploy:assets:precompile"].clear_actions

# ✅ Gán RAILS_MASTER_KEY từ shared/config/master.key vào ENV
namespace :master_key do
  desc "Load master key from shared config"
  task :load do
    on roles(:app) do
      master_key_path = "#{shared_path}/config/master.key"
      if test("[ -f #{master_key_path} ]")
        master_key = capture(:cat, master_key_path).strip
        set :rails_master_key, master_key
        set :default_env, fetch(:default_env, {}).merge(
          "RAILS_MASTER_KEY" => master_key,
          "NODE_OPTIONS" => "--openssl-legacy-provider"
        )
      else
        error "❌ Missing #{master_key_path} on server."
      end
    end
  end
end

before "deploy:starting", "master_key:load"

# ✅ Restart Puma sau khi publish
namespace :deploy do
  desc "Restart Puma"
  task :restart do
    invoke "puma:restart"
  end

  after :publishing, :restart
end
