source 'https://rubygems.org'

ruby '2.3.4'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.2'

# HTML
gem 'slim-rails'
gem 'simple_form', '~> 3.5.0'
gem 'bootstrap-sass'
gem 'font-awesome-rails'

# Browser
gem 'browser'

# Crawling
gem 'nokogiri'

# Auth
gem 'devise'
gem 'devise_invitable'
gem 'omniauth-facebook'

# OAuth2 provider
gem 'doorkeeper'
gem 'devise-doorkeeper'

# Attachment
gem 'paperclip'
gem 'aws-sdk', '~> 2.10.21'

# Pattern
gem 'interactor'
gem 'interactor-rails'

# Queue
gem 'sidekiq'
gem 'sinatra', require: nil, github: 'sinatra/sinatra'

# Schedule
gem 'whenever'

# i18n
gem 'rails-i18n'

# api
gem 'active_model_serializers'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 3.0'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Environment variables
gem 'dotenv-rails'

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console'
  gem 'listen', '~> 3.0.5'

  gem 'bullet'
  gem 'better_errors'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development, :test do
  # Use debugger
  gem 'byebug', platform: :mri
  gem 'pry-byebug'
end

group :test do
  # Tests
  gem 'rspec-rails', '~> 3.6'
  gem 'capybara'
  gem 'shoulda', '~> 3.5'
  gem 'simplecov'
  gem 'codeclimate-test-reporter', '~> 1.0'
end

# Error notification
gem 'rollbar'

# Use unicorn as the app server
group :production do
  gem 'puma', '~> 3.0'
end
