source 'http://rubygems.org'

gem 'rails', '3.0.10'
gem 'rake', '0.8.7'         # remove this line when rails 3.1
gem 'mysql2', '= 0.2.7'     # version needed for rails 3.0

gem 'jquery-rails', '>= 0.2.6'
gem 'haml'

gem 'capistrano'

# Gem gives easy translating helpers and translates models
gem 'r18n-rails'

# Gem adds locale to each route
gem 'translate_routes'

# auth gem
gem 'devise'

# gem for aploading files, that mus belongs to models
gem 'paperclip', '~> 2.3'

# Magic gem for parsing and building XML and HTML
# gem 'nokogiri'


# Testing gems
group :development, :test do
  gem "rspec-rails"
  # until bugfix with :to_ary not incuded into gem:
  gem "rspec-mocks", :git => "git://github.com/rspec/rspec-mocks.git"
  gem "cucumber-rails"
  gem 'webrat'
  gem 'capybara', "= 1.0.0.beta1"   # remove this line when rails 3.1
end

group :test do
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'email_spec'
end
