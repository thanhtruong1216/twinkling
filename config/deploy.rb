# config valid for current version and patch releases of Capistrano
lock "~> 3.19.2"

set :application, "star"
set :repo_url, "git@github.com:thanhtruong1216/twinkling.git"

set :deploy_to, "/var/www/star"

# Shared files and directories between releases
append :linked_files,
       'config/database.yml',
       'config/master.key',
       'config/credentials/production.yml.enc',
       'config/credentials/production.key'

append :linked_dirs,
       'log',
       'tmp/pids',
       'tmp/cache',
       'tmp/sockets',
       'public/system',
       'storage',
       'node_modules'

set :keep_releases, 5

namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'puma:restart'
  end

  after :publishing, :restart

  desc "Run yarn install"
  task :yarn_install do
    on roles(:web) do
      within release_path do
        execute :yarn, "install", "--check-files"
      end
    end
  end

  desc "Precompile assets"
  task :compile_assets do
    on roles(:web) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, "exec rake assets:precompile"
        end
      end
    end
  end

  # Run yarn before assets precompile
  before 'deploy:assets:precompile', 'deploy:yarn_install'

  # Optional: recompile assets again after updated if needed
  after 'deploy:updated', 'deploy:compile_assets'
end
