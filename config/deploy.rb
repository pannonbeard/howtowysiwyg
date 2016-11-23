# config valid only for current version of Capistrano
lock '3.4.0'
set :application, "eetraining"

# Server Settings
# ==================
set :deploy_to, "/home/deploy/apps/#{fetch(:application)}"
set :shared_config_path, shared_path.join("config")

# Deploy/SSH Config
# ==================
set :repo_url, "ssh://git@bitbucket.org/pfhendri/eetraining.git"
set :scm, :git
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
set :keep_releases, 3

# Slackistrano
# ==================
# BAD! Figure out a way to use Rails.application.secrets instead and recreate webhook

## Linked Files
# ==================
set :linked_files, %w{config/database.yml config/ldap.yml config/secrets.yml}
set :linked_dirs, %w{log tmp/pids}

## Rbenv Config
# ==================
set :rbenv_type, :user
set :rbenv_ruby, File.read('.ruby-version').strip


# work around problem with sshkit 1.8.0,
# see https://github.com/capistrano/sshkit/issues/303
# and https://github.com/capistrano/rbenv/pull/59
set :rbenv_custom_path, "$HOME/.rbenv"

namespace :deploy do

  desc "Restart application"
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join("tmp/restart.txt")
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, "cache:clear"
      # end
    end
  end

  after :publishing, "deploy:restart"
  after :finishing, "deploy:cleanup"

end
