# frozen_string_literal: true
require 'capistrano/rails/assets'

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

# Keep last 5 releases
set :keep_releases, 5

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

# Webpacker manifest (for Rails + Webpacker)
set :assets_manifests, ['public/packs/manifest.json']
set :keep_releases, 3

# Run yarn install before assets precompile
before 'deploy:assets:precompile', 'deploy:yarn_install'

namespace :deploy do
  desc 'Run yarn install'
  task :yarn_install do
    on roles(:web) do
      within release_path do
        execute :yarn, 'install --production=false --silent --no-progress'
      end
    end
  end

  # Set RAILS_MASTER_KEY from shared config before starting deploy
  task :set_master_key do
    on roles(:app) do
      key = capture(:cat, "#{shared_path}/config/master.key").strip
      set :default_env, { 'RAILS_MASTER_KEY' => key }
      info "RAILS_MASTER_KEY set from #{shared_path}/config/master.key"
    end
  end

  set :default_env, { 'NODE_OPTIONS' => '--openssl-legacy-provider' }
  before 'deploy:starting', 'deploy:set_master_key'
end

# Puma setup
set :puma_threads, [4, 16]
set :puma_workers, 2
set :puma_bind, "tcp://127.0.0.1:3000"
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{shared_path}/log/puma.access.log"
set :puma_error_log, "#{shared_path}/log/puma.error.log"
set :puma_preload_app, true
set :puma_init_active_record, true

# Optional: skip normalize timestamp (optional with Webpacker)
set :normalize_asset_timestamps, false
