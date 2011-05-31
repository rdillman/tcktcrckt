require 'bundler/capistrano'

set :application, "www.tcktcrckt.com"

set :scm, :git
set :repository,  "."
set :deploy_via, :copy

set :user, :deploy
set :deploy_to, "/var/www/#{application}"
set :use_sudo, false


# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "www.tcktcrckt.com"                          # Your HTTP server, Apache/etc
role :app, "www.tcktcrckt.com"                          # This may be the same as your `Web` server
role :db,  "www.tcktcrckt.com", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end