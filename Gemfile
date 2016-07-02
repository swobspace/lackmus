source 'https://rubygems.org'

gem 'rails', '~> 4.2.6'
gem 'pg'
gem 'postgres_ext'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'jquery-ui-rails'
gem 'simple_form'
gem 'wobapphelpers', git: 'https://github.com/swobspace/wobapphelpers', branch: 'master'
gem 'bower-rails', '~> 0.10.0'
gem 'data-confirm-modal', git: 'https://github.com/ifad/data-confirm-modal.git'

gem 'whois'
gem 'packetfu'
gem 'acts_as_list'
gem 'immutable-struct'

group :development do
  gem 'thin'
  gem 'guard'
  gem 'guard-livereload', require: false
  gem 'guard-rails'
  gem 'guard-bundler'
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'capistrano-rails'
  gem 'capistrano-passenger'
  gem "railroady"
  gem "better_errors"
  gem "binding_of_caller"
  gem "meta_request"
end

group :test, :development do
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
  gem 'dotenv'
  gem 'guard-rspec', require: false
  gem 'byebug'
  gem "json_spec"
end

group :test do
  gem 'shoulda-matchers', require: false
  gem 'fakeweb', "~> 1.3", require: false
  gem 'factory_girl_rails'
  gem 'database_rewinder'
  gem 'capybara'
  gem 'poltergeist'
end

gem 'cancancan'
gem 'wobauth', git: 'https://github.com/swobspace/wobauth.git', branch: 'master'
