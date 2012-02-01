# encoding: utf-8

require 'rubygems'
require 'rake'
require 'jeweler'
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))
require 'ramix/version'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name        = "ramix"
  gem.version     = Ramix::VERSION::STRING
  gem.homepage    = "http://github.com/zires/ramix"
  gem.license     = "MIT"
  gem.summary     = %Q{new rails application generator}
  gem.description = %Q{Ramix is a command-line tool for initializing a new rails application.Just the same as rails but adding more additional options.}
  gem.email       = "zshuaibin@gmail.com"
  gem.authors     = ["Thierry Zires"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

task :default => :test

require 'yard'
YARD::Rake::YardocTask.new
