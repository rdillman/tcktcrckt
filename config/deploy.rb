set :application, "tcktcrckt"

set :scm, :git
set :repository,  "git@github.com:rdillman/tcktcrckt.git"
set :branch, "master"
set :deploy_via, :remote_cache


set :user, :deploy
set :deploy_to, "/src/www/#{application}"
set :use_sudo, false
ssh_options[:forward_agent] = true
ssh_options[:verbose] = :debug
set :port, 16888



# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "tcktcrckt.com"                          # Your HTTP server, Apache/etc
role :app, "tcktcrckt.com"                          # This may be the same as your `Web` server
role :db,  "tcktcrckt.com", :primary => true # This is where Rails migrations will run
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