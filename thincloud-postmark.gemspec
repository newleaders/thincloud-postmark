# -*- encoding: utf-8 -*-
require File.expand_path("../lib/thincloud/postmark/version", __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Robert Bousquet", "Phil Cohen"]
  gem.email         = ["rbousquet@newleaders.com", "pcohen@newleaders.com"]
  gem.description   = "Postmark configuration for Rails apps."
  gem.summary       = "Postmark configuration for Rails apps."
  gem.homepage      = "http://newleaders.github.com/thincloud-postmark"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "thincloud-postmark"
  gem.require_paths = ["lib"]
  gem.version       = Thincloud::Postmark::VERSION

  gem.add_development_dependency "rails", "~> 3.2.8"

  gem.add_development_dependency "cane", "~> 2.3.0"
  gem.add_development_dependency "guard", "~> 1.3.3"
  gem.add_development_dependency "minitest", "~> 3.4.0"
  gem.add_development_dependency "guard-minitest", "~> 0.5.0"
  gem.add_development_dependency "minitest-rails", "~> 0.1.3"
  gem.add_development_dependency "minitest-rails-shoulda", "~> 0.1.0"
  gem.add_development_dependency "rb-fsevent", "~> 0.9.1"
  gem.add_development_dependency "simplecov", "~> 0.6.4"
  gem.add_development_dependency "mocha", "~> 0.12.4" # Must be after minitest

  gem.add_runtime_dependency "postmark-rails", "~> 0.4.1"
end
