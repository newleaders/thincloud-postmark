require "bundler/gem_tasks"
require "rake/testtask"

task default: [:test, :cane, :rubocop]

desc "Run minitest suite"
Rake::TestTask.new(:test) do |t|
  t.libs << "lib"
  t.libs << "test"
  t.pattern = "test/**/*_test.rb"
  t.verbose = false
end

require "cane/rake_task"
desc "Run cane to check quality metrics"
Cane::RakeTask.new(:cane) do |cane|
  cane.abc_max = 8
  cane.style_measure = 80
end

require "rubocop/rake_task"
RuboCop::RakeTask.new

# dummy rails app
APP_RAKEFILE = File.expand_path("../test/dummy/Rakefile", __FILE__)
load "rails/tasks/engine.rake"
