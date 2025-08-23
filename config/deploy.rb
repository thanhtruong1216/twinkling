# config valid for current version and patch releases of Capistrano
lock "~> 3.19.2"

set :application, "star"
set :repo_url, "git@github.com:thanhtruong1216/twinkling.git"

# Thư mục deploy trên server
set :deploy_to, "/var/www/#{fetch(:application)}"

# Các file và thư mục dùng chung giữa các release
append :linked_files, "config/master.key", "config/database.yml", "config/credentials/production.key"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "storage"

# Giữ lại số release gần nhất
set :keep_releases, 1

# Ruby version (rbenv user install)
set :rbenv_type, :user
set :rbenv_ruby, '3.2.3'

# Yarn flags khi chạy yarn install
set :yarn_flags, '--silent --no-progress'

# Thiết lập biến môi trường (đảm bảo RAILS_MASTER_KEY được load)
set :default_env, lambda {
  master_key_path = "#{shared_path}/config/master.key"
  master_key = File.exist?(master_key_path) ? File.read(master_key_path).strip : ""
  {
    "RAILS_MASTER_KEY" => master_key,
    "NODE_OPTIONS" => "--openssl-legacy-provider"
  }
}

namespace :deploy do
  desc "Run yarn install on server"
  task :yarn_install do
    on roles(:web) do
      within release_path do
        execute :yarn, "install --production=false #{fetch(:yarn_flags)}"
      end
    end
  end

  desc "Restart application by touching tmp/restart.txt for Passenger"
  task :restart do
    on roles(:app) do
      within release_path do
        execute :touch, "tmp/restart.txt"
      end
    end
  end

  before 'deploy:assets:precompile', 'deploy:yarn_install'
  after :publishing, :restart
end
