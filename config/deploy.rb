lock "~> 3.19.2"

set :application, "star"
set :repo_url, "git@github.com:thanhtruong1216/twinkling.git"
set :branch, "master"
set :deploy_to, "/var/www/star"
set :user, "deploy"

set :linked_files, fetch(:linked_files, []).push(
  'config/database.yml',
  'config/master.key'
)
set :linked_dirs, fetch(:linked_dirs, []).push(
  'log',
  'tmp/pids',
  'tmp/cache',
  'tmp/sockets',
  'vendor/bundle',
  '.bundle',
  'public/system',
  'public/uploads',
  'storage'
)

# Set default_env từ đầu
set :default_env, {
  'NODE_OPTIONS' => '--openssl-legacy-provider'
}

# Đọc master.key và set RAILS_MASTER_KEY trước khi precompile
namespace :master_key do
  desc "Load master key content from server"
  task :load do
    on roles(:app) do
      master_key = capture(:cat, "#{shared_path}/config/master.key").strip
      set :rails_master_key, master_key

      # Merge vào default_env
      fetch(:default_env)['RAILS_MASTER_KEY'] = master_key
    end
  end
end

# Đảm bảo chạy trước precompile
before 'deploy:assets:precompile', 'master_key:load'

# Restart puma sau deploy
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'puma:restart'
  end
end
