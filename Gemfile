source 'https://rubygems.org'

# Project-specific gems
gem 'high_voltage', '~> 2.3.0'
gem 'paranoia', '~> 2.1.2'
gem 'bootstrap-sass', '~> 3.3.4'
gem 'font-awesome-sass', '~> 4.3.2.1'
gem 'mailchimp-api', require: 'mailchimp'
gem 'figaro', '~> 1.1.1'
gem 'email_validator', '~> 1.6.0'
gem 'lodash-rails', '~> 3.7.0'
gem 'devise', '~> 3.5.1'
gem 'devise_invitable', '~> 1.5.1'
gem 'braintree', '~> 2.45.0'
gem 'rails_admin', '~> 0.6.8'
gem 'rails_admin_pundit', github: 'sudosu/rails_admin_pundit'
gem 'animate-rails', '~> 1.0.8'
gem 'jquery-validation-rails', '~> 1.13.1'
gem 'pundit', '~> 1.0.1'
gem 'faker', '~> 1.4.3'
gem 'paperclip', '~> 4.3.0'
gem 'rdiscount', '~> 2.1.8'
gem 'quiet_assets', '~> 1.1.0'
gem 'friendly_id', '~> 5.1.0'
gem 'twilio-ruby', '~> 4.13'

# Rails-specific gems
gem 'rails', '4.2.0'
gem 'pg'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'bundler', '>= 1.8.4'
source 'https://rails-assets.org' do
  gem 'rails-assets-scrollmagic', '~> 2.0.5'
  gem 'rails-assets-autoNumeric', '~> 1.9.39'
end

group :stage, :integration, :development, :test do
  gem 'factory_girl_rails', '~> 4.5.0'
end

group :integration, :development, :test do
  # Project-specific gems
  gem 'rubocop', require: false
  gem 'letter_opener', '~> 1.3.0'
  gem 'letter_opener_web', '~> 1.3.0'

  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring'
end

group :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'shoulda-matchers', '~> 2.8.0'
  gem 'rspec-its', '~> 1.2.0'
  gem 'json-schema', '~> 2.5.1'
  gem 'database_cleaner', '~> 1.4.1'
  gem 'fake_braintree', '~> 0.6.0'
end
