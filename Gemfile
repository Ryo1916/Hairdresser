source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# ruby
ruby '2.5.0'

# basic
gem 'rails',               '5.1.6'
gem 'puma',                '3.9.1'
gem 'uglifier',            '3.2.0'
gem 'turbolinks',          '5.0.1'
gem 'jbuilder',            '2.7.0'
gem 'friendly_id',         '5.2.4'
gem 'acts-as-taggable-on', '6.0'

# css
gem 'bootstrap',               '4.1.3'
gem 'sass-rails',              '5.0.6'
gem 'will_paginate',           '3.1.6'
gem 'bootstrap-will_paginate', '1.0.0'
gem 'font-awesome-sass',       '5.6.1'
gem 'tinymce-rails',           '4.9.1'

# js
gem 'jquery-rails', '4.3.1'
gem 'coffee-rails', '4.2.2'
gem 'popper_js',    '1.14.3'

# i18n
gem 'i18n',                 '~> 0.5'
gem 'rails-i18n',           '5.1.1'
gem 'http_accept_language', '2.1.1'
gem 'i18n-tasks',           '0.9.25'

# file upload
gem 'carrierwave', '1.2.3'
gem 'mini_magick', '4.9.2'

# account
gem 'devise',            '4.5'
gem 'activeadmin',       '1.3.1'
gem 'letter_opener_web', '1.3.4'

# others
gem 'faker',     '1.7.3'
gem 'rails-erd', '1.5.2'


group :development, :test do
  gem 'mysql2',   '0.5.2'
  gem 'annotate', '2.7.4'
  gem 'byebug',  '10.0', platform: :mri
  gem 'capybara',                 '~> 2.13'
  gem 'selenium-webdriver',       '3.141.0'
  gem 'chromedriver-helper',      '2.1.0'
  gem 'rspec-rails',              '3.8.1'
  gem 'rails-controller-testing', '1.0.4'
  gem 'factory_bot_rails',        '4.11.1'
  gem 'shoulda-matchers',         '3.1.2'
  gem 'database_cleaner',         '1.7.0'
  gem 'simplecov',                '0.16.1'
  gem 'test-queue',               '0.4.2'
  gem 'guard',                    '2.13.0'
end

group :development do
  gem 'web-console',           '3.5.1'
  gem 'listen',                '3.1.5'
  gem 'spring',                '2.0.2'
  gem 'spring-watcher-listen', '2.0.1'
  gem 'better_errors',         '2.5.0'
  gem 'binding_of_caller',     '0.8.0'
  gem 'pry-byebug',            '3.6.0'
  gem 'pry-rails',             '0.3.9'
  gem 'pry-doc',               '1.0.0'
end

group :production do
  gem 'pg',  '1.1.3'
  gem 'fog', '1.42'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
