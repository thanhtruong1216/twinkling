threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }.to_i
threads threads_count, threads_count

# Bind TCP port 3000
port ENV.fetch("PORT") { 3000 }

workers ENV.fetch("WEB_CONCURRENCY") { 2 }
environment ENV.fetch("RAILS_ENV") { "production" }

pidfile "/var/www/star/shared/tmp/pids/puma.pid"
state_path "/var/www/star/shared/tmp/pids/puma.state"
directory "/var/www/star/current"

preload_app!

on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end

stdout_redirect '/var/www/star/shared/log/puma.stdout.log', '/var/www/star/shared/log/puma.stderr.log', true
