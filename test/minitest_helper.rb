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
require "minitest/pride"
