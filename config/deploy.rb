# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'lesstweets'
set :format, :simpletext
set :repo_url, 'git@bitbucket.org:lesseverything/lesstweets.git'
set :deploy_to, "/less/app"
set :stage, 'production'
set :remote_user, 'general'
set :branch, ENV["REV"]

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'vendor/bundle', 'public/system')
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/application.yml', 'config/secrets.yml')

#################
# Delayed job
#################
namespace :deploy do
  before :finishing, :delayed_job_start do
    on roles(:app) do
      execute "/less/app/current/script/service/delayed_job_stop"
    end
  end

  after :finishing, :delayed_job_stop do
    on roles(:app) do
      execute "/less/app/current/script/service/delayed_job_start"
    end
  end
end
