source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.7'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.6.0" # https://github.com/ixti/sidekiq-throttled/pull/13
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false
gem 'devise'
gem 'autoprefixer-rails', '10.2.5'
gem 'font-awesome-sass', '~> 5.6.1'
gem 'simple_form', github: 'heartcombo/simple_form'

# Seeds
gem 'faker', :git => 'https://github.com/faker-ruby/faker.git', :branch => 'main'

# Policies
gem 'pundit', "~> 2.3"

# Background jobs
gem "sidekiq", "6.4.2" # FIXME: https://github.com/mperham/sidekiq/issues/5372
gem 'sidekiq-failures'
gem 'devise-async'

# Active Record
gem 'enumerize'
gem 'active_storage_validations'
gem 'geocoder'

# Views
gem 'view_component'

# Active Storage
gem 'cloudinary'

# SEO
gem 'sitemap_generator'
gem 'friendly_id'

# Mailer in prod
gem 'postmark-rails'

# API
gem 'rswag'
gem 'rack-cors'

# Search bar
gem 'pg_search'

# SQL views
gem 'scenic'

# PDF generator
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'

# Maintenance tasks
gem "maintenance_tasks", "1.8.2"

# Translations
gem 'rails-i18n', '~> 6.0'

group :development, :test do  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'dotenv-rails'

  # Tests
  gem 'rspec-rails', '~> 6.0.0'
  gem 'factory_bot_rails'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md

  # N+1 queries
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'bullet'

  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'letter_opener_web', '~> 2.0'
  gem 'annotate'

  # Better errors
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'

  # Rspec tests
  gem 'shoulda-matchers', '~> 5.3'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
