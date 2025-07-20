# frozen_string_literal: true

lock "~> 3.19.2"

set :application, "star"
set :repo_url, "git@github.com:thanhtruong1216/twinkling.git"
set :deploy_to, "/var/www/star"

# RBENV cấu hình chuẩn
set :rbenv_type, :user
set :rbenv_ruby, '3.2.2'
set :rbenv_custom_path, '/home/ubuntu/.rbenv'
set :rbenv_prefix, "#{fetch(:rbenv_custom_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w[rake gem bundle ruby rails yarn]
set :rbenv_roles, :all

# Môi trường (PATH chuẩn để rbenv hoạt động)
set :default_env, {
  'RBENV_ROOT' => fetch(:rbenv_custom_path),
  'RBENV_VERSION' => fetch(:rbenv_ruby),
  'PATH' => "#{fetch(:rbenv_custom_path)}/shims:#{fetch(:rbenv_custom_path)}/bin:$PATH",
  'NODE_OPTIONS' => '--openssl-legacy-provider'
}

# Shared files và thư mục
append :linked_files, 'config/database.yml', 'config/master.key'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'storage', 'node_modules'

set :keep_releases, 5

# Load master.key từ thư mục shared trước khi check linked files
namespace :master_key do
  desc "Load Rails master.key from shared"
  task :load do
    on roles(:app) do
      mk = capture(:cat, "#{shared_path}/config/master.key").strip
      set :default_env, fetch(:default_env).merge('RAILS_MASTER_KEY' => mk)
    end
  end
end
before 'deploy:check:linked_files', 'master_key:load'

namespace :deploy do
  desc 'Install yarn packages'
  task :yarn_install do
    on roles(:web) do
      within release_path do
        execute :yarn, 'install', '--check-files'
      end
    end
  end

  # desc 'Precompile Rails assets'
  # task :precompile do
  #   on roles(:web) do
  #     within release_path do
  #       with rails_env: fetch(:rails_env) do
  #         execute :bundle, 'exec', 'rake', 'assets:clobber'
  #         execute :bundle, 'exec', 'rake', 'assets:precompile'
  #       end
  #     end
  #   end
  # end

  # # Các bước chạy sau cập nhật code
  # after 'deploy:updated', 'deploy:yarn_install'
  # after 'deploy:yarn_install', 'deploy:precompile'

  # desc 'Restart Puma'
  # task :restart do
  #   invoke 'puma:restart'
  # end
  # after 'deploy:publishing', 'deploy:restart'

  # after :finishing, 'deploy:cleanup'
end
