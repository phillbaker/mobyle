source :rubygems

RAILS_VERSION = '~> 3.2.8'
DM_VERSION    = '~> 1.2.0'

gem 'activesupport',  RAILS_VERSION, :require => 'active_support'
gem 'actionpack',     RAILS_VERSION, :require => 'action_pack'
gem 'actionmailer',   RAILS_VERSION, :require => 'action_mailer'
gem 'activeresource', RAILS_VERSION, :require => 'active_resource'
gem 'railties',       RAILS_VERSION, :require => 'rails'
gem 'tzinfo',         '~> 0.3.32'

gem 'dm-core',            '~> 1.2.0'
gem 'dm-rails',           '~> 1.2.1'
gem 'dm-sqlite-adapter',  DM_VERSION
gem 'dm-migrations',      DM_VERSION
gem 'dm-types',           DM_VERSION
gem 'dm-validations',     DM_VERSION
gem 'dm-constraints',     DM_VERSION
gem 'dm-transactions',    DM_VERSION
gem 'dm-aggregates',      DM_VERSION
gem 'dm-timestamps',      DM_VERSION
gem 'dm-observer',        DM_VERSION

gem 'dm-serializer',     '~> 1.2.0'
gem 'dm-devise',         '~> 2.1.0'
gem 'data_objects',      '0.10.8' # data_objects (0.10.9) doesn't like compiling on ubuntu...
gem 'dm-is-tree'          
gem 'dm-paperclip', :git => 'git://github.com/phillbaker/dm-paperclip.git', :branch => 'bug-dm1.2.0-rails3.2.8-ruby1.8.7' # Use in place of regular paperclip for jquery-fileupload-rails
gem 'devise_invitable', :git => 'git://github.com/phillbaker/devise_invitable.git', :branch => 'datamapper-compatibility' #TODO => push as dm-invitable?

gem 'cancan'
gem 'simple_form'
gem 'breadcrumbs_on_rails'

# Maintenance
gem 'turnout', :git => 'git://github.com/phillbaker/turnout.git', :branch => 'fix-remove-require' #:path => '../turnout' # has a silly require 'active_record'...

# Gems used only for asset compliation and not required
# in production environments by default.
group :assets do
  gem 'less-rails' # Do before sass-rails so that scaffolding is done with less
  gem 'sass-rails',   '~> 3.2.5' # Required by jquery_mobile_rails
  gem 'sprockets'
  gem 'therubyracer'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier',     '~> 1.2.4'
end

gem 'jquery-fileupload-rails'
gem 'jquery-rails', '~> 2.0.1'
gem 'less-rails-bootstrap'
# vs.  twitter-bootstrap-rails ?
gem 'jquery_mobile_rails', :git => 'git://github.com/phillbaker/jquery-mobile-rails.git', :branch => 'fix-gem-require'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.1'

# Use unicorn as the web server
# gem 'unicorn', '~> 4.2.1'

group :deploy do
  # Deploy with Capistrano
  # gem 'highline', '1.6.13' #1.6.14
  # gem 'capistrano', '~>2.11.2' #'2.13.0'
  # gem 'capistrano_colors'
end
gem 'rvm-capistrano'

# To use debugger
# gem 'ruby-debug19', '~> 0.11.6', :require => 'ruby-debug'

group :development do
  gem 'thin'
end

# Put dm-fixture in dev + test to make its rake tasks available by default
group :development, :test do
  gem 'dm-fixtures'
end

group :test do
  # Pretty printed test output
  gem 'turn', '~> 0.9.4', :require => false
  
  # For ActiveRecord::Fixtures
  # gem 'activerecord', RAILS_VERSION, :require => 'active_record'
  # gem 'sqlite3'
end
