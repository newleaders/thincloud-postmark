source "https://rubygems.org"

# Declare your gem's dependencies in thincloud-resque.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

gem "rails", "~> 3.2.19"
gem "jquery-rails"  # jquery-rails is used by the dummy application

group :local do
  gem "travis"
end

group :test do
  gem "codeclimate-test-reporter", require: false
  gem "rake"
  gem "rubocop"
  gem "simplecov"
  gem "sqlite3"
end
