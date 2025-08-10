server "47.130.153.142", user: "ubuntu", roles: %w{app db web}

set :migration_role, :app

set :ssh_options, {
  user: 'ubuntu',
  keys: %w(~/.ssh/id_rsa),
  forward_agent: true,
  auth_methods: %w(publickey),
  timeout: 60
}

append :linked_files, 'config/master.key'
set :rbenv_type, :user
set :rbenv_ruby, '3.2.3'
