source 'https://rubygems.org'

ruby '2.1.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.1'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# HTML
gem 'slim-rails'
gem 'simple_form', '~> 3.1.0.rc1'
gem 'bootstrap-sass'
gem 'font-awesome-rails'

# Auth
gem 'devise'
gem 'devise_invitable'
gem 'omniauth-facebook'

# Attachment
gem 'paperclip'

# Pattern
gem "interactor"
gem "interactor-rails"

# Queue
gem 'sidekiq'
gem 'sinatra', require: nil

# Schedule
gem 'whenever'

# i18n
gem 'rails-i18n'

# api
gem "active_model_serializers"

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Environment variables
gem 'dotenv-rails'

group :development do
  gem 'bullet'
  gem 'better_errors'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # deploy
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-sidekiq'
end

group :development, :test do
  # Use debugger
  gem 'pry-nav'
end

group :test do
  # Tests
  gem 'rspec-rails', '~> 3.0.0.rc1'
  gem 'capybara'
  gem 'shoulda'
  gem 'coveralls', require: false
  gem "codeclimate-test-reporter", require: false
end

# Use unicorn as the app server
group :production do
  gem 'unicorn'
  gem 'unicorn-rails'
end
