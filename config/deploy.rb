require 'bundler/capistrano'
require 'config/deploy/notifier.rb'
# BAD_BUNDLE = false
# NOTIFY = false
require 'rubygems'
require 'bundler/setup'
load 'deploy/assets' #unless BAD_BUNDLE #== bundle exec rake RAILS_ENV=production RAILS_GROUPS=assets assets:precompile

#TODO suppress warnings on tar extract on remote (http://www.gnu.org/software/tar/manual/html_section/warnings.html)
# --warning=no-timestamp #cd /var/www/ihub.phillbaker.com/releases && tar xzf /tmp/20121010031941.tar.gz && rm /tmp/20121010031941.tar.gz
# deploy:update_code

set :application, "ihub.phillbaker.com"
set :deploy_to, "/var/www/#{application}"

set :user, "branch"

set :scm, :git
set :repository,  "."
set :deploy_via, :copy
set :copy_strategy, :export

set :use_sqlite3, true

set :notify_emails, ["me@retrodict.com", "fgencorelli@gmail.com"]

set :shared_database_path, "#{shared_path}/db"
set :shared_config_path, "#{shared_path}/config"

role :web, "173.230.155.35"                          # Your HTTP server, Apache/etc
role :app, "173.230.155.35"                          # This may be the same as your `Web` server
role :db,  "173.230.155.35", :primary => true

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

namespace :bundle do
  task :install do
    # Same as default, just don't be quiet
    run "cd #{current_release} && bundle install --verbose --gemfile #{current_release}/Gemfile --path #{shared_path}/bundle --deployment --without development test" #unless BAD_BUNDLE
  end
end

after "deploy:setup", "configuration:make_default_folders"
after "deploy:setup", "configuration:deploy_apache_configuration"

after "deploy", 'deploy:migrate' #unless BAD_BUNDLE # Auto upgrade tables, for dm

if use_sqlite3
  after "deploy:setup", "sqlite3:make_shared_folder"
  after "deploy:setup", "sqlite3:build_configuration"
  
  #additional 
  # after "deploy:cold", "db:seed" #TODO setup this up for dm, basic root user
  
  before "deploy:create_symlink", "sqlite3:link_configuration_file"
end

# Create the task to send the notification
namespace :deploy do
  desc "Email notifier"
  task :notify do
    Notifier.deploy_notification(self).deliver
  end
end

# Setup the emails, and after deploy hook
# after "deploy", "deploy:notify" if NOTIFY
