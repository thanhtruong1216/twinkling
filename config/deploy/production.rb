server "54.255.209.35", user: "ubuntu", roles: %w{app db web}

set :migration_role, :app

set :ssh_options, {
  user: 'ubuntu', 
  keys: %w(~/Downloads/waterfall.pem),
  forward_agent: true,
  auth_methods: %w(publickey),
  timeout: 60
}

set :repo_url, 'git@github.com:thanhtruong1216/twinkling.git'
