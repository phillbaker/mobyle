require "bundler/capistrano"
load 'deploy/assets'

set :application, "ihub.phillbaker.com"

set :user, "branch"
set :repository,  "."
set :deploy_to, "/var/www/#{application}"
set :deploy_via, :copy
set :copy_strategy, :export
set :use_sqlite3, true
set :scm, :git

set :shared_database_path, "#{shared_path}/db"
set :shared_config_path, "#{shared_path}/config"

role :web, "173.230.155.35"                          # Your HTTP server, Apache/etc
role :app, "173.230.155.35"                          # This may be the same as your `Web` server
role :db,  "173.230.155.35", :primary => true        # This is where Rails migrations will run
#role :db,  "your slave db-server here"

namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
end

namespace :configuration do
  desc "Makes link for database config"
  task :make_default_folders, :roles => :app do
    run "mkdir -p #{shared_config_path}"
  end
  
  desc "Sets Apache config file"
  task :deploy_apache_configuration, :roles => :app do
    upload "config/#{application}", "#{shared_config_path}/#{application}"
    sudo "ln -sf #{shared_path}/config/#{application} /etc/apache2/sites-available/#{application}", :pty => true
    # Restart Apache, run as separate commands so each is prefixed with 'sudo'
    sudo "a2ensite #{application}"
    sudo "apache2ctl graceful"
  end
end

# http://www.bagonca.com/blog/2009/05/09/rails-deploy-using-sqlite3/
namespace :sqlite3 do
  desc "Generate a database configuration file"
  task :build_configuration, :roles => :db do
    db_options = {
      "adapter"  => "sqlite",
      "database" => "#{shared_database_path}/production.sqlite3"
    }
    config_options = {"production" => db_options}.to_yaml
    put config_options, "#{shared_config_path}/sqlite_config.yml"
  end
 
  desc "Links the configuration file"
  task :link_configuration_file, :roles => :db do
    run "ln -nsf #{shared_config_path}/sqlite_config.yml #{release_path}/config/database.yml"
  end
 
  desc "Make a shared database folder"
  task :make_shared_folder, :roles => :db do
    run "mkdir -p #{shared_database_path}"
  end
end

# Passenger mod_rails
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :db do
  desc "Populates the production database"
  task :seed do
    puts "\n\n=== Populating the Production Database! ===\n\n"
    run "cd #{current_path}; bundle exec rake RAILS_ENV=production db:seed"
  end
end

after "deploy:setup", "configuration:make_default_folders"
after "deploy:setup", "configuration:deploy_apache_configuration"

after "deploy", 'deploy:migrate' # Auto upgrade tables, for dm

if use_sqlite3
  after "deploy:setup", "sqlite3:make_shared_folder"
  after "deploy:setup", "sqlite3:build_configuration"
  
  #additional 
  # after "deploy:cold", "db:seed" #TODO setup this up for dm
  
  before "deploy:create_symlink", "sqlite3:link_configuration_file"
end