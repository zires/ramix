require 'rubygems' if RUBY_VERSION < '1.9'

begin
  require 'rails/version'
  require 'rails/generators'
  require 'rails/generators/rails/app/app_generator'
rescue LoadError
  puts "**Note** Rails is not available. Type `gem install rails` to install rails."
  exit
end

if Rails::VERSION::MAJOR < 3
  puts "Sorry, ramix only support rails version above 3."
  exit
end

require 'ramix/app_generator'