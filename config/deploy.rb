# config/deploy.rb

lock "~> 3.19.2"

set :application, "star"
set :repo_url, "git@github.com:thanhtruong1216/twinkling.git"
set :branch, "master"
set :deploy_to, "/var/www/star"
set :user, "deploy"

# Liên kết các file cấu hình quan trọng
set :linked_files, fetch(:linked_files, []).push(
  'config/database.yml',
  'config/master.key'
)

# Liên kết các thư mục cần giữ lại giữa các bản phát hành
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

# ❌ Bỏ qua precompile assets
Rake::Task["deploy:assets:precompile"].clear_actions

# ✅ Load master.key tự động từ server để set ENV RAILS_MASTER_KEY
namespace :master_key do
  desc "Load master key content from server"
  task :load do
    on roles(:app) do
      if test("[ -f #{shared_path}/config/master.key ]")
        master_key = capture(:cat, "#{shared_path}/config/master.key").strip
        set :default_env, fetch(:default_env, {}).merge({
          'RAILS_MASTER_KEY' => master_key,
          'NODE_OPTIONS' => '--openssl-legacy-provider'
        })
      else
        error "⚠️  Missing #{shared_path}/config/master.key. Please upload it first."
        exit 1
      end
    end
  end
end

before 'deploy:starting', 'master_key:load'

# ✅ Restart Puma sau khi publish xong
after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'puma:restart'
  end
end
