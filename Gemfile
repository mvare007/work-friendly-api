source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.4', '>= 7.0.4.3'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# A simple and fast JSON API template engine for Ruby on Rails
gem 'jb'

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

#  A Scope & Engine based, clean, powerful, customizable and sophisticated paginator
gem 'kaminari'

# Minimal authorization through OO design and pure Ruby classes
gem 'pundit'

# Simple, Fast, and Declarative Serialization Library for Ruby https://github.com/procore/blueprinter
gem 'blueprinter'

# Optimized JSON http://www.ohler.com/oj/
gem 'oj'

# Doorkeeper is an OAuth 2 provider https://doorkeeper.gitbook.io/guides/ruby-on-rails/
gem 'doorkeeper'

# Flexible authentication solution for Rails with Warden.
gem 'devise'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]

  # A library for generating fake data such as names, addresses, and phone numbers.
  gem 'faker'

  # A fixtures replacement with a straightforward definition syntax, support for multiple build strategies (saved instances, unsaved instances, attribute hashes, and stubbed objects), and support for multiple factories for the same class (user, admin_user, and so on), including factory inheritance.
  gem 'factory_bot_rails'
end

group :development do
  # Annotate Rails classes with schema and routes info
  gem "annotaterb"

  # Catch unsafe migrations
  gem 'strong_migrations'

  #A RuboCop extension focused on enforcing Rails best practices and coding conventions.
  gem 'rubocop-rails', require: false

  # An extension of RuboCop focused on code performance checks.
  gem 'rubocop-performance', require: false
end

group :test do
  # A set of RSpec matchers for testing Pundit authorisation policies.
  gem 'pundit-matchers', '~> 2.1'

  # Makes tests easy on the fingers and the eyes
  gem 'shoulda'
end
