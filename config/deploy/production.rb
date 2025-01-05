server '3.141.41.196', user: 'ubuntu', roles: %w{app web db}
set :migration_role, :app

set :ssh_options, {
  user: 'ubuntu',                        # Correct user
  keys: %w(ThanhTruong.pem),    # Correct path to your SSH key
  forward_agent: true,
  auth_methods: %w(publickey),
  timeout: 60
}

set :repo_url, 'git@github.com:thanhtruong1216/twinkling.git'
