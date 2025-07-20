# frozen_string_literal: true

lock "~> 3.19.2"

set :application, "star"
set :repo_url, "git@github.com:thanhtruong1216/twinkling.git"
set :deploy_to, "/var/www/star"

# Ruby version và cấu hình rbenv
set :rbenv_type, :user
set :rbenv_ruby, '3.2.2'
set :rbenv_custom_path, '/home/ubuntu/.rbenv'
set :rbenv_prefix, "#{fetch(:rbenv_custom_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails yarn}

# Force PATH
set :default_env, fetch(:default_env, {}).merge({
  'RBENV_ROOT' => fetch(:rbenv_custom_path),
  'PATH' => "#{fetch(:rbenv_custom_path)}/shims:#{fetch(:rbenv_custom_path)}/bin:$PATH",
  'NODE_OPTIONS' => '--openssl-legacy-provider'
})

# File và thư mục dùng chung giữa các bản release
append :linked_files, 'config/database.yml', 'config/master.key'
append :linked_dirs,
  'log',
  'tmp/pids',
  'tmp/cache',
  'tmp/sockets',
  'public/system',
  'storage',
  'node_modules'

set :keep_releases, 5

# Load master.key từ shared trước khi deploy
namespace :master_key do
  desc "Load master key from shared path"
  task :load do
    on roles(:app) do
      master_key = capture(:cat, "#{shared_path}/config/master.key").strip
      set :default_env, fetch(:default_env, {}).merge({
        'RAILS_MASTER_KEY' => master_key
      })
    end
  end
end

before 'deploy:check:linked_files', 'master_key:load'

namespace :deploy do
  desc 'Yarn install on server'
  task :yarn_install do
    on roles(:web) do
      within release_path do
        execute :yarn, 'install', '--check-files'
      end
    end
  end

  desc 'Precompile assets on server'
  task :precompile_assets do
    on roles(:web) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, 'exec', 'rake', 'assets:precompile'
        end
      end
    end
  end

  before 'deploy:symlink:release', 'deploy:yarn_install'
  before 'deploy:symlink:release', 'deploy:precompile_assets'

  desc 'Restart app'
  task :restart do
    invoke 'puma:restart'
  end

  after :publishing, :restart
end
