source 'https://rubygems.org'

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.3'

# Core gems
gem 'rails', '~> 7.0' # Nên định rõ version để tránh update gây lỗi
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 6.0'

# Frontend & assets
gem 'bootstrap', '~> 5.3'
# gem 'bootstrap-sass' # Bỏ nếu không dùng bootstrap 3/4 với sass, không nên dùng cùng bootstrap gem
gem 'sass-rails', '~> 6.0'
gem 'webpacker', '~> 4.0' # Nếu là Rails 7, cân nhắc chuyển sang jsbundling-rails
gem 'turbolinks', '~> 5'
gem 'slim'
gem 'kaminari'
gem 'simple_form'

# Image processing
gem 'mini_magick'
gem 'mimemagic', github: 'mimemagicrb/mimemagic', ref: '01f92d86d15d85cfd0f20dabd025dcbd36a8a60f' # Hoặc thay bằng 'marcel'
gem 'active_storage_validations'
gem 'aws-sdk-s3', require: false

# Authentication & authorization
gem 'devise'
gem 'devise_token_auth'
gem 'omniauth'
gem 'friendly_id', '~> 5.4.0'
gem 'bcrypt_pbkdf', '~> 1.0'
gem 'ed25519', '~> 1.2'

# Utilities and networking
gem 'faker'
gem 'nokogiri', '1.15.2'
gem 'rack-cors'
gem 'psych', '< 4.0.0'
gem 'meta-tags'

# Net libraries
gem 'net-ssh'
gem 'net-smtp', require: false
gem 'net-imap', require: false
gem 'net-pop', require: false

# Capistrano deployment
gem 'capistrano'
gem 'capistrano-rails'
gem 'capistrano-rbenv'
gem 'capistrano-bundler'
gem 'capistrano-rails-console'
gem 'capistrano-puma', require: false
gem 'capistrano-git'
gem 'capistrano-rails-collection'
gem 'capistrano-passenger'

# Performance
gem 'bootsnap', '>= 1.4.2', require: false
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'listen', '~> 3.0'
gem 'geocoder'

group :development, :test do
  gem 'rspec-rails', '>= 4.0.0.beta2'
  gem 'factory_bot_rails'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rails-controller-testing'
end

group :development do
  gem 'spring', '>= 3.0.0'
  gem 'spring-watcher-listen', '~> 2.1.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 3.38.0'
  gem 'guard-rspec'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'webdrivers'
end

