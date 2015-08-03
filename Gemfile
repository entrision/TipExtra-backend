source 'https://rubygems.org'

gem 'rails', '4.2.3'
gem 'pg'

gem 'capistrano'
gem 'capistrano-rvm'
gem 'capistrano-bundler'
gem 'capistrano-rails'

gem 'devise'
gem 'simple_token_authentication'
gem 'active_model_serializers'
gem 'braintree'
gem 'carrierwave'
gem 'rmagick', require: false
gem 'fog'
gem 'exception_notification'
gem 'sidekiq'

group :staging, :production do
  gem 'unicorn'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring'
end

group :test do
  gem 'webmock'
  gem 'vcr'
end

