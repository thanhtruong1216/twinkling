
lock '3.19.2'

set :application, 'star'
set :repo_url, 'git@github.com:thanhtruong1216/twinkling.git'

set :deploy_to, '/var/www/star'
set :branch, 'master'  # Or the branch you want to deploy from

set :user, 'ubuntu'   # The user to SSH into your EC2 instance
set :use_sudo, false

set :ssh_options, {
  user: 'ubuntu',                        # Correct user
  keys: %w(ThanhTruong.pem),    # Correct path to your SSH key
  forward_agent: true,
  auth_methods: %w(publickey),
  timeout: 60
}

set :git_ssh_env, { 'GIT_SSH_COMMAND' => 'ssh -i ThanhTruong.pem -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null' }
set :use_sudo, true
