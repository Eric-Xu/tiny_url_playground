source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.0.0'

group :development, :test do
	gem 'sqlite3'
	gem 'rspec-rails', '2.13.1'
end

group :test do
	gem 'selenium-webdriver', '2.0.0'
	gem 'capybara', '2.1.0'
	gem 'factory_girl_rails', '4.2.1'
	gem 'cucumber-rails', '1.4.0', :require => false
	gem 'database_cleaner', github: 'bmabey/database_cleaner'
end

gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 1.2'
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'nokogiri'
gem 'will_paginate', '3.0.4'

group :doc do
  gem 'sdoc', require: false
end

group :production do
	gem 'pg', '0.15.1'
	gem 'rails_12factor', '0.0.2'
end