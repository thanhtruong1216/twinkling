# config/deploy.rb

lock "~> 3.19.2"

set :application, "star"
set :repo_url, "git@github.com:thanhtruong1216/twinkling.git"
set :branch, "master"
set :deploy_to, "/var/www/star"
set :user, "deploy"

# Đảm bảo các file và thư mục được liên kết
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

# Tải master.key từ shared folder và set vào default_env để Rails precompile không lỗi
namespace :master_key do
  desc "Load master key content from server"
  task :load do
    on roles(:app) do
      master_key = capture(:cat, "#{shared_path}/config/master.key").strip

      set :default_env, fetch(:default_env, {}).merge(
        'RAILS_MASTER_KEY' => master_key,
        'NODE_OPTIONS' => '--openssl-legacy-provider'
      )
    end
  end
end

# Load master key trước khi asset:precompile hoặc bất kỳ task nào cần nó
before 'deploy:starting', 'master_key:load'

# Restart puma sau khi deploy xong
after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  task :restart do
    invoke 'puma:restart'
  end
end
