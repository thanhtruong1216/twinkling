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

# Local precompile assets setup
set :assets_roles, [:web]
set :local_precompile, true
set :assets_manifests, ['public/packs/manifest.json']

# Environment variables
set :default_env, {
  'RAILS_MASTER_KEY' => File.read('config/master.key').strip,
  'NODE_OPTIONS' => '--openssl-legacy-provider'
}

namespace :deploy do
  desc 'Run yarn install'
  task :yarn_install do
    on roles(:web) do
      within release_path do
        execute :yarn, 'install --production --frozen-lockfile --silent'
      end
    end
  end
  before 'deploy:assets:precompile', 'deploy:yarn_install'

  desc 'Set RAILS_MASTER_KEY on server'
  task :set_master_key do
    on roles(:app) do
      key = capture(:cat, "#{shared_path}/config/master.key").strip
      set :default_env, fetch(:default_env).merge('RAILS_MASTER_KEY' => key)
      info "RAILS_MASTER_KEY set from shared config"
    end
  end
  before 'deploy:starting', 'deploy:set_master_key'

  desc 'Clean old assets before precompile'
  task :assets_prepare do
    on roles(fetch(:assets_roles)) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'assets:clean'
        end
      end
    end
  end
  Rake::Task["deploy:assets:prepare"].clear_actions if Rake::Task.task_defined?("deploy:assets:prepare")
  before 'deploy:assets:precompile', 'deploy:assets_prepare'
end

# Puma setup
set :puma_threads, [4, 16]
set :puma_workers, 2
set :puma_bind, "tcp://127.0.0.1:3000"
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{shared_path}/log/puma.access.log"
set :puma_error_log, "#{shared_path}/log/puma.error.log"
