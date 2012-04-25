source 'https://rubygems.org'

# thin web server
gem 'thin'

gem 'rails', '3.2.3'

# haml templating
gem 'haml-rails'

# curb http client requests
gem 'curb'

# coffee-script monkey patch line for making mercury work
gem "coffee-script-source", "1.2.0"

# mercury live editor
gem 'mercury-rails'

# quiet assets suppresses asset related log messages
gem 'quiet_assets', :group => :development

# Databases
# Local: SQLite3
# Heroku: Postgres
# via http://railsapps.github.com/rails-heroku-tutorial.html

group :development, :test do
  gem 'sqlite3'
end
group :production do
  gem 'pg'
end

# RocketTag high speed tagging
gem 'rocket_tag', git: 'git://github.com/bradphelan/rocket_tag.git'

# Loofah HTML sanitizer based on Nokogiri
gem 'loofah'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'
end

# jQuery Rails (Rails 3.1+ default)
# gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
