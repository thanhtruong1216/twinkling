# frozen_string_literal: true

# Lock Capistrano to a specific version
lock '3.19.2'

# Load DSL and set up stages
require 'capistrano/setup'
require 'capistrano/deploy'

require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git

require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano/passenger'

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
