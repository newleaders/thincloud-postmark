# -*- encoding: utf-8 -*-
require File.expand_path("../lib/thincloud/postmark/version", __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Robert Bousquet", "Phil Cohen", "Kenny Johnston",
                       "Don Morrison"]
  gem.email         = ["rbousquet@newleaders.com", "pcohen@newleaders.com",
                       "kjohnston@newleaders.com", "dmorrison@newleaders.com"]
  gem.description   = "Postmark configuration for Rails apps."
  gem.summary       = "Postmark configuration for Rails apps."
  gem.homepage      = "http://newleaders.github.com/thincloud-postmark"

  gem.files         = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)
  gem.executables   = gem.files.grep(/^bin\//).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(/^(test|spec|features)\//)
  gem.name          = "thincloud-postmark"
  gem.require_paths = ["lib"]
  gem.version       = Thincloud::Postmark::VERSION
  gem.licenses      = ["MIT"]

  gem.add_dependency "postmark-rails", "~> 0.10.0"

  gem.add_development_dependency "thincloud-test-rails"
  gem.add_development_dependency "rails", "~> 3.2.21"
  gem.add_development_dependency "rubocop"
  gem.add_development_dependency "sqlite3"
end
