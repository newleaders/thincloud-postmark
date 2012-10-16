if RUBY_ENGINE == "ruby"
  begin
    require "simplecov"
    SimpleCov.add_filter "test"
    SimpleCov.add_filter "config"
    SimpleCov.command_name "MiniTest"
    SimpleCov.start
  rescue LoadError
    warn "unable to load SimpleCov"
  end
end

ENV["RAILS_ENV"] = "test"

require "minitest/autorun"
require "minitest/pride"

require "thincloud-postmark"
require "thincloud/postmark/configuration"

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
