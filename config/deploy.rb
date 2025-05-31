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
append :linked_files, 'config/master.key', 'config/database.yml'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'storage'

# Keep last 5 releases
set :keep_releases, 5

# SSH
set :user, 'ubuntu'
set :use_sudo, false

set :ssh_options, {
  user: 'ubuntu',
  keys: %w(~/Downloads/waterfall.pem), # Đường dẫn tới file SSH key trên máy local
  forward_agent: true,
  auth_methods: %w(publickey),
  timeout: 60
}

# Nếu repo dùng SSH
set :git_ssh_env, {
  'GIT_SSH_COMMAND' => 'ssh -i waterfall.pem -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
}

# Puma setup
set :puma_threads, [4, 16]
set :puma_workers, 2
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{shared_path}/log/puma.error.log"
set :puma_error_log, "#{shared_path}/log/puma.access.log"
set :puma_preload_app, true
set :puma_init_active_record, true
