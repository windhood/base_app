source 'http://rubygems.org'

gem 'rails', '3.0.6'
gem 'bundler', '>= 1.0.0'

#Security
gem 'devise', '>=1.1.4'
#gem 'devise-mongo_mapper', :git => 'git://github.com/collectiveidea/devise-mongo_mapper'
gem 'devise_invitable', '0.3.5'

#DB
gem 'sqlite3-ruby', :require => 'sqlite3'

#Authentication
gem 'omniauth', '0.1.6'
gem 'twitter', :git => 'git://github.com/jnunemaker/twitter.git', :ref => 'ef122bbb280e229ed343'

#Views
gem 'haml'
gem 'haml-rails' #haml generator 
gem 'inherited_resources', '>=1.1.2'
gem 'will_paginate', '>=3.0.pre2'
gem 'formtastic', '>=1.1.0'
gem 'compass', '>= 0.10.5'
gem 'html5-boilerplate', :git => 'git@github.com:windhood/compass-html5-boilerplate.git'
# gem 'compass-960-plugin'
#gem 'compass-susy-plugin'
gem 'maruku', '>= 0.5.9'
gem 'jammit'

# active_admin
#gem 'activeadmin', :git => 'git@github.com:windhood/active_admin.git'

# Deploy 
gem 'inploy', '>=1.6.8'
gem 'heroku'
# gem 'hassle', :git => 'git://github.com/koppen/hassle.git'

#Uncatagorized
gem 'friendly_id', '~>3.0'
gem 'newrelic_rpm', '>=2.12.3', :group => :production
gem 'hoptoad_notifier', '>=2.3.6'
gem 'rails3-generators', :git => 'git://github.com/indirect/rails3-generators.git'
gem 'metric_fu', '>=1.5.1', :group => :development
gem 'annotate-models', '1.0.4', :group => :development
gem 'rails_best_practices', '0.6.5', :group => :development
gem 'hpricot', :group => :development #used for generating devise views

group :test, :development do
  gem 'rspec-rails', '>= 2.5.0'
  gem 'factory_girl_rails'
  gem 'factory_girl_generator', '>= 0.0.1'
  #gem 'ruby-debug19' if RUBY_VERSION.include? "1.9"
  #gem 'ruby-debug' if RUBY_VERSION.include? "1.8"
  gem 'launchy'
  gem 'spork', '>=0.9.0.rc5'
end

group :test do
  gem 'capybara', '>= 0.4.0'
  gem 'cucumber-rails', '>=0.4.0'
  gem 'rspec', '>= 2.5.0'  
  gem 'mocha'
  gem 'database_cleaner', '>=0.5.2'
  gem 'webmock', :require => false
  #gem 'jasmine', :path => 'vendor/gems/jasmine', :require => false
  #gem 'mongrel', :require => false if RUBY_VERSION.include? "1.8"
  gem 'rspec-instafail', :require => false
  gem 'pickle'
end

group :deployment do
  #gem 'sprinkle', :git => 'git://github.com/rsofaer/sprinkle.git'
end