# config/deploy.rb

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

# Bỏ qua precompile
Rake::Task["deploy:assets:precompile"].clear_actions

# Tự động load master.key + NODE_OPTIONS (nếu cần)
namespace :master_key do
  desc "Load master key content from server"
  task :load do
    on roles(:app) do
      master_key = capture(:cat, "#{shared_path}/config/master.key").strip
      set :rails_master_key, master_key

      set :default_env, fetch(:default_env, {}).merge({
        'RAILS_MASTER_KEY' => master_key,
        'NODE_OPTIONS' => '--openssl-legacy-provider'
      })
    end
  end
end

before 'deploy:starting', 'master_key:load'

# Restart Puma sau khi deploy
namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'puma:restart'
  end

  after :publishing, :restart
end
