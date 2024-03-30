source "https://rubygems.org"

ruby "3.3.0"

# gem "bcrypt", "~> 3.1.7"
# gem "redis", ">= 4.0.1"
gem "bootsnap", require: false
gem "bugsnag"
gem "devise"
gem "importmap-rails"
gem "pg"
gem "puma"
gem "rails"
gem "sprockets-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[windows jruby]

group :development, :test do
  gem "debug", platforms: %i[mri windows]
  gem "i18n-tasks", require: false, git: "https://github.com/glebm/i18n-tasks.git", branch: "main"
  gem "rubocop", require: false
  gem "rubocop-capybara", require: false
  gem "rubocop-minitest", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rake", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
