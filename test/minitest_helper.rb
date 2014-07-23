require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require "simplecov"
SimpleCov.start do
  add_filter { |src| src.filename =~ /bundle|test|config|vendor/ }
  command_name "Minitest"
end

ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment",  __FILE__)

require "minitest/autorun"
require "minitest/rails"
require "minitest/pride"
require "minitest-rails-shoulda"

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
