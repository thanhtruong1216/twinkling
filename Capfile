# frozen_string_literal: true

# Lock Capistrano to a specific version
lock '3.19.2'

# Load DSL and set up stages
require 'capistrano/setup'
require 'capistrano/local_precompile'

# Include default deployment tasks
require 'capistrano/deploy'

# Load Git SCM plugin
require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git

# Load rbenv (Ruby environment)
require 'capistrano/rbenv'
set :rbenv_type, :user
set :rbenv_ruby, '3.2.2'

# Load bundler for installing gems
require 'capistrano/bundler'

# Load Rails tasks (assets, migrations)
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'

# Load Puma for app server
require 'capistrano/puma'

# Optional: if using db:seed on deploy
# require 'capistrano/seed'

# Load custom tasks from lib/capistrano/tasks
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
