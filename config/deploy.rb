# frozen_string_literal: true

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

# Keep last releases
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

# Assets: compile locally, NOT on server
set :assets_roles, [:web]
set :assets_prefix, 'assets'
set :compile_assets_locally, true

# Xóa task precompile mặc định trên server để không chạy
Rake::Task["deploy:assets:precompile"].clear_actions if Rake::Task.task_defined?("deploy:assets:precompile")

# Load master.key từ server shared folder
namespace :master_key do
  desc "Load master key content from server"
  task :load do
    on roles(:app) do
      master_key = capture(:cat, "#{shared_path}/config/master.key").strip
      set :rails_master_key, master_key
    end
  end
end
before 'deploy:starting', 'master_key:load'

set :default_env, -> {
  {
    'RAILS_MASTER_KEY' => fetch(:rails_master_key),
    'NODE_OPTIONS' => '--openssl-legacy-provider'
  }
}

# YARN install trước khi precompile assets (local)
namespace :deploy do
  desc 'Run yarn install locally'
  task :yarn_install_local do
    run_locally do
      execute "yarn install --production --frozen-lockfile --silent"
    end
  end
  before 'deploy:assets:precompile', 'deploy:yarn_install_local'

  # Task precompile assets local và upload lên server
  desc 'Precompile assets locally and upload'
  task :precompile_assets_locally do
    run_locally do
      execute "RAILS_ENV=production bundle exec rake assets:clobber assets:precompile"
      execute "rsync -av --delete public/assets/ #{fetch(:user)}@#{fetch(:server)}:#{shared_path}/public/assets/"
    end
  end
  before 'deploy:updated', 'deploy:precompile_assets_locally'
end

# Puma setup
set :puma_threads, [4, 16]
set :puma_workers, 2
set :puma_bind, "tcp://127.0.0.1:3000"
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{shared_path}/log/puma.access.log"
set :puma_error_log, "#{shared_path}/log/puma.error.log"
set :bundle_flags, '--deployment --quiet --without development test --jobs 1'
