# frozen_string_literal: true

# ❗️Chú ý: KHÔNG require capistrano/rails/assets nếu bạn build assets trên server
# require 'capistrano/rails/assets' ❌ LOẠI BỎ DÒNG NÀY

lock '3.19.2'

set :application, 'star'
set :repo_url, 'git@github.com:thanhtruong1216/twinkling.git'
set :branch, 'master'
set :deploy_to, '/var/www/star'

# Ruby setup
set :rbenv_type, :user
set :rbenv_ruby, '3.2.2'

# Shared files/folders
append :linked_files, 'config/master.key', 'config/database.yml', 'config/credentials/production.key', 'config/credentials/production.yml.enc'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'storage'

# Keep only last 1 release (to save space)
set :keep_releases, 1

# SSH
set :user, 'ubuntu'
set :use_sudo, false
set :ssh_options, {
  user: 'ubuntu',
  keys: %w(~/.ssh/id_rsa),
  forward_agent: true,
  auth_methods: %w(publickey),
  timeout: 600
}

# ❌ Tắt toàn bộ các task liên quan đến precompile local (bắt buộc khi không dùng capistrano/rails/assets)
%w[
  deploy:assets:prepare
  deploy:assets:precompile
  deploy:assets:backup_manifest
  deploy:assets:restore_manifest
  deploy:assets:clean
].each do |task_name|
  Rake::Task[task_name].clear_actions rescue nil
end

# ✅ Precompile assets thủ công trên server
namespace :deploy do
  desc 'Precompile assets on server'
  task :precompile_assets do
    on roles(:web) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, 'exec rake assets:precompile'
        end
      end
    end
  end

  before 'deploy:symlink:release', 'deploy:precompile_assets'
end

# Load master.key từ server
namespace :master_key do
  desc "Load master key from shared path"
  task :load do
    on roles(:app) do
      master_key = capture(:cat, "#{shared_path}/config/master.key").strip
      set :rails_master_key, master_key
    end
  end
end
before 'deploy:starting', 'master_key:load'

# ENV cho rbenv + node
set :default_env, -> {
  {
    'RAILS_MASTER_KEY' => fetch(:rails_master_key),
    'NODE_OPTIONS' => '--openssl-legacy-provider'
  }
}

# Bundler config an toàn
namespace :bundler do
  desc "Set bundler configs safely"
  task :setup_config do
    on roles(:app) do
      within release_path do
        execute :bundle, "config set deployment 'true'"
        execute :bundle, "config set without 'development test'"
        execute :bundle, "config set jobs 1"
        execute :bundle, "config set silence_root_warning true || true"
      end
    end
  end
end
before 'bundler:install', 'bundler:setup_config'

# Puma setup (tối ưu cho EC2 t2.micro)
set :puma_threads, [2, 4]
set :puma_workers, 1
set :puma_bind, "tcp://127.0.0.1:3000"
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{shared_path}/log/puma.access.log"
set :puma_error_log, "#{shared_path}/log/puma.error.log"
