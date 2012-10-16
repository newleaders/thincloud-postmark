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

  gem.add_development_dependency "thincloud-test", "~> 0.3.2"

  gem.add_runtime_dependency "postmark-rails", "~> 0.4.1"
end
