source 'https://gems.ruby-china.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.3.18', '< 0.5'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

gem 'grape'
gem 'grape-entity', '~> 0.5.1'
gem 'grape-swagger'
gem 'grape-swagger-rails'

# gem 'will_paginate', '3.1.0'
# gem 'bootstrap-will_paginate', '0.0.10'

# gem 'kaminari'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
# Ruby wrapper for integrate Wechat Open Platform into Rails projects
# https://github.com/lanrion/weixin_rails_middleware
gem 'weixin_rails_middleware', '~> 1.3', '>= 1.3.2'

# rQRCode is a library for encoding QR Codes. The simple interface allows you to create QR Code data structures ready to be displayed in the way you choose.
# https://github.com/whomwah/rqrcode
gem 'rqrcode', '~> 0.10.1'

# Wechat high level API wrapper written in Ruby
# https://github.com/lanrion/weixin_authorize
gem 'weixin_authorize', '~> 1.6', '>= 1.6.4'
gem 'font-awesome-sass', '~> 4.7.0'
# Easiest way to manage multi-environment settings in any ruby project or framework: Rails, Sinatra, Pandrino and others
# https://rubygems.org/gems/config
gem 'config', '~> 1.3'

# https://github.com/rstgroup/active_skin
# Flat skin for active admin.
gem 'active_skin'

# Flexible authentication solution for Rails with Warden
# https://github.com/plataformatec/devise
gem 'devise'

# The administration framework for Ruby on Rails applications. http://activeadmin.info
# https://github.com/activeadmin/activeadmin
# Active Admin master has preliminary support for Rails 5. To give it a try, these Gemfile changes may be needed:
gem 'inherited_resources', github: 'activeadmin/inherited_resources'
gem 'activeadmin'


# https://github.com/carrierwaveuploader/carrierwave
# Classier solution for file uploads for Rails, Sinatra and other Ruby web frameworks
gem 'carrierwave', '~> 0.11.2'

# https://rubygems.org/gems/mini_magick
# Manipulate images with minimal use of memory via ImageMagick / GraphicsMagick
gem 'mini_magick', '~> 4.5', '>= 4.5.1'

# https://github.com/galetahub/ckeditor/
# CKEditor is a WYSIWYG text editor designed to simplify web content creation. It brings common word processing features directly to your web pages. Enhance your website experience with our community maintained editor. ckeditor.com
gem 'ckeditor', '~> 4.2.4'

# Full HMAC auth implementation for use in your gems and Rails apps.
# https://rubygems.org/gems/api-auth
gem 'api-auth', '~> 2.0', '>= 2.0.1'

# https://rubygems.org/gems/rest-client
# A simple HTTP and REST client for Ruby, inspired by the Sinatra microframework style of specifying actions: get, put, post, delete.
gem 'rest-client', '~> 2.0'

# Clean ruby syntax for writing and deploying cron jobs.
# https://github.com/javan/whenever
gem 'whenever', '~> 0.9.7', :require => false

# https://rubygems.org/gems/activeadmin_addons
# Set of addons to help with the activeadmin ui
gem 'activeadmin_addons', '~> 0.10.1'

# Track changes to your models' data. Good for auditing or versioning.
# https://github.com/airblade/paper_trail/blob/4.0-stable/README.md
gem 'paper_trail', '~> 4.0.2'

# Exception notification for Rails apps
# https://github.com/smartinez87/exception_notification
gem 'exception_notification', '~> 4.1', '>= 4.1.4'

# Create beautiful JavaScript charts with one line of Ruby
# http://chartkick.com/
# NOTE: 需要更改数据库时区： https://github.com/ankane/groupdate#for-mysql
# mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root -p mysql
# SET sql_mode = ''
# set global sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
# set session sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION'
gem 'chartkick', '~> 2.2', '>= 2.2.3'

# Gem that includes Highcharts (Interactive JavaScript charts for your web projects), in the Rails Asset Pipeline introduced in Rails 3.1
# https://rubygems.org/gems/highcharts-rails
gem 'highcharts-rails', '~> 5.0', '>= 5.0.7'

# The simplest way to group temporal data
# https://github.com/ankane/groupdate
gem 'groupdate', '~> 3.2'

# Ransack is the successor to the MetaSearch gem. It improves and expands upon MetaSearch's functionality, but does not have a 100%-compatible API
# https://rubygems.org/gems/ransack
gem 'ransack', '~> 1.8', '>= 1.8.2'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  # rspec-rails is a testing framework for Rails 3.x, 4.x and 5.0. https://github.com/rspec/rspec-rails
  gem 'rspec-rails', '~> 3.7'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # Use Capistrano for deployment
  gem 'capistrano', "~> 2.15.5"
  gem 'rvm-capistrano', '~> 1.4.1', :require => false
  gem 'awesome_print'
  gem 'certified'    #ssl 证书
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'rails-i18n'
gem 'china_sms'
gem 'china_city'
gem 'aasm'
gem 'cancancan'

