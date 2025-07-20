# config/deploy.rb

lock "~> 3.19.2"

set :application, "star"
set :repo_url, "git@github.com:thanhtruong1216/twinkling.git"
set :branch, "master"
set :deploy_to, "/var/www/star"
set :user, "deploy"

# Linked files/directories
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

# ✅ Bỏ qua precompile assets
Rake::Task["deploy:assets:precompile"].clear_actions

# ✅ Load master.key và NODE_OPTIONS từ shared config
namespace :master_key do
  desc "Load master key from server"
  task :load do
    on roles(:app) do
      master_key_path = "#{shared_path}/config/master.key"
      if test("[ -f #{master_key_path} ]")
        master_key = capture(:cat, master_key_path).strip
        set :default_env, fetch(:default_env, {}).merge(
          'RAILS_MASTER_KEY' => master_key,
          'NODE_OPTIONS' => '--openssl-legacy-provider'
        )
      else
        error "⚠️ File master.key không tồn tại ở #{master_key_path}"
      end
    end
  end
end

before 'deploy:starting', 'master_key:load'

# ✅ Restart Puma sau deploy
namespace :deploy do
  task :restart do
    invoke 'puma:restart'
  end
end

after 'deploy:publishing', 'deploy:restart'
