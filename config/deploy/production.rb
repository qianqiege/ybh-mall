# config/deploy/production.rb
set :app_server, "120.24.7.180"
set :app_url, "http://ybhm.ybyt.cc"
set :application, app_server
role :web, app_server
role :app, app_server
role :db,  app_server, :primary => true
set :deploy_to, "/var/www/ybhm.ybyt.cc"
set :user, "deploy"
set :rvm_ruby_string, "ruby-2.3.0"
set :branch, "master"
set :rails_env, "production"
