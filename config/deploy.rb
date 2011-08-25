require 'bundler/capistrano'

set :application, "tcktcrckt"

set :scm, :git
set :repository,  "."
set :deploy_via, :copy


set :user, :deploy
set :deploy_to, "/var/www/#{application}"
set :use_sudo, false
set :port, 16888



# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "parkingcricket.com"                          # Your HTTP server, Apache/etc
role :app, "parkingcricket.com"                          # This may be the same as your `Web` server
role :db,  "parkingcricket.com", :primary => true # This is where Rails migrations will run
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

desc "tail production log files" 
task :tail_logs, :roles => :app do
  run "tail -f #{shared_path}/log/production.log" do |channel, stream, data|
    puts  # for an extra line break before the host name
    puts "#{channel[:host]}: #{data}" 
    break if stream == :err    
  end
end