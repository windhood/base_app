source 'http://rubygems.org'

gem 'rails', '3.0.0'
gem 'bundler', '>= 1.0.0'

#Security
gem 'devise', '>=1.1.3'
#gem 'devise-mongo_mapper', :git => 'git://github.com/collectiveidea/devise-mongo_mapper'
gem 'devise_invitable', '~> 0.3.4'

#DB
gem 'sqlite3-ruby', :require => 'sqlite3'

#Views
gem 'haml'
gem 'haml-rails' #haml generator 
gem 'inherited_resources', '>=1.1.2'
gem 'will_paginate', '>=3.0.pre2'
gem 'formtastic', '>=1.1.0'
gem 'compass', '>= 0.10.5'
gem 'html5-boilerplate'
gem 'compass-960-plugin'

# Deploy 
gem 'inploy', '>=1.6.8'
gem 'heroku'
gem 'hassle', :git => 'git://github.com/koppen/hassle.git'

#Uncatagorized
gem 'friendly_id', '~>3.0'
gem 'newrelic_rpm', '>=2.12.3', :group => :production
gem 'hoptoad_notifier', '>=2.3.6'
gem 'rails3-generators', :git => 'git://github.com/indirect/rails3-generators.git'
gem 'metric_fu', '>=1.5.1', :group => :development

group :test, :development do
  gem 'rspec-rails', '>=2.0.0.rc'
  gem 'factory_girl_rails'
  #gem 'ruby-debug' if RUBY_VERSION.include? "1.8"
end

group :test do
  gem 'rspec', '>=2.0.0.rc'
  gem 'remarkable', '>=4.0.0.alpha4'
  gem 'remarkable_activemodel', '>=4.0.0.alpha4'
  gem 'cucumber', '>=0.6.3'
  gem 'cucumber-rails', '>=0.3.2'
  gem 'capybara', '~> 0.3.9'
  gem 'mocha'
  gem 'database_cleaner','>=0.5.0'
  gem 'webmock'
  gem 'spork', '>=0.8.4'
  gem 'pickle', '>=0.4.2'
end