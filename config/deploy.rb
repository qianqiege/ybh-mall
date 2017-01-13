require 'mina/rails'
require 'mina/git'
require 'mina/rvm' 
# require 'mina/rbenv'  # for rbenv support. (https://rbenv.org)
# require 'mina/rvm'    # for rvm support. (https://rvm.io)
set :term_mode, nil
# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :application_name, 'YBH-mall'

set :user, 'ybhmall'
set :domain, '120.77.8.108'
set :port, '10086'
deploy_to =  '/home/ybhmall/public/rails'
set :deploy_to, '/home/ybhmall/public/rails'
set :repository, 'git@git.oschina.net:ybyt/YBH-mall.git'
set :branch, 'master'

# Optional settings:
#   set :user, 'foobar'          # Username in the server to SSH to.
#   set :port, '30000'           # SSH port number.
#   set :forward_agent, true     # SSH forward_agent.

# shared dirs and files will be symlinked into the app-folder by the 'deploy:link_shared_paths' step.
# set :shared_dirs, fetch(:shared_dirs, []).push('somedir')
# set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/secrets.yml')
set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/secrets.yml')
set :shared_dirs, fetch(:shared_dirs, []).push('log')
# This task is the environment that is loaded for all remote run commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .ruby-version or .rbenv-version to your repository.
  # invoke :'rbenv:load'
  invoke :'rvm:use', 'ruby-2.2.2@default'
  # For those using RVM, use this to load an RVM version@gemset.
  # invoke :'rvm:use', 'ruby-1.9.3-p125@default'
end

# Put any custom commands you need to run at setup
# All paths in `shared_dirs` and `shared_paths` will be created on their own.
task :setup do
  command %{rvm install ruby-2.2.2}
  command %{mkdir -p "#{deploy_to}/shared/log"}
  command %{chmod g+rx,u+rwx "#{deploy_to}/shared/log"}

  command %{mkdir -p "#{deploy_to}/shared/config"}
  command %{chmod g+rx,u+rwx "#{deploy_to}/shared/config"}

  command %{touch "#{deploy_to}/shared/config/database.yml"}
  command %{touch "#{deploy_to}/shared/config/secrets.yml"}
  comment  %{Be sure to edit 'shared/config/database.yml' and 'shared/config/secrets.yml'.}

  command %{mkdir -p "#{deploy_to}/shared/pids"}
  command %{chmod g+rx,u+rwx "#{deploy_to}/shared/pids"}
  command %{touch "#{deploy_to}/shared/pids/unicorn.pid"}

  command %{mkdir -p "#{deploy_to}/shared/sockets"}
  command %{chmod g+rx,u+rwx "#{deploy_to}/shared/sockets"}
end

desc "Deploys the current version to the server."
task :deploy do
  # uncomment this line to make sure you pushed your local branch to the remote origin
  # invoke :'git:ensure_pushed'
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

  end

  # you can use `run :local` to run tasks on local machine before of after the deploy scripts
  # run(:local){ say 'done' }
end

task :reload do
  invoke :'unicorn:restart'
end


namespace :unicorn do

#                                                                    Start task
# ------------------------------------------------------------------------------
  desc "Start unicorn"
  task :start => :environment do
    comment 'Start Unicorn'
    command %{cd #{deploy_to}/current && unicorn -c config/unicorn.rb -E production -D}
  end

#                                                                     Stop task
# ------------------------------------------------------------------------------
  desc "Stop unicorn"
  task :stop do
    comment 'Stop Unicorn'
    command %{test -s "#{deploy_to}/shared/pids/unicorn.pid" && kill -QUIT `cat "#{deploy_to}/shared/pids/unicorn.pid"` && rm -rf "#{deploy_to}/shared/pids/unicorn.pid" && echo "Stop Ok" || echo >&2 "Not running"}
  end

#                                                                  Restart task
# ------------------------------------------------------------------------------
  desc "Restart unicorn using 'upgrade'"
  task :restart => :environment do
    invoke 'unicorn:stop'
    invoke 'unicorn:start'
  end
end
# For help in making your deploy script, see the Mina documentation:
#
#  - https://github.com/mina-deploy/mina/tree/master/docs
