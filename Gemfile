source "https://rubygems.org"

ruby "2.7.1"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.3", ">= 7.1.3.4"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use sqlite3 as the database for Active Record (only in development and test)
gem "sqlite3", "~> 1.4", group: [:development, :test]

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mswin mswin64 mingw x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Authentication and Authorization
gem 'devise'
gem 'activeadmin'
gem 'pundit'

# Pagination
gem 'kaminari'

# Image processing and validations
gem 'image_processing', '~> 1.2'
gem 'active_storage_validations'

# Payments
gem 'stripe'

# Environment variables management
gem 'dotenv-rails', groups: [:development, :test]

# Full-text search
gem 'pg_search'

gem 'faker'

gem 'quilljs-rails'
gem 'activeadmin_quill_editor'
gem 'ransack'


group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mswin mswin64 mingw x64_mingw ]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end

group :production do
  # Use PostgreSQL as the database for Active Record in production
  gem "pg", ">= 0.18", "< 2.0"
  # Use Redis adapter to run Action Cable in production
  gem "redis", ">= 4.0.1"
end

group :assets do
  gem 'sassc-rails'
end