require 'rubygems' if RUBY_VERSION < '1.9'

begin
  require 'rails/generators'
  require 'rails/generators/rails/app/app_generator'
rescue LoadError
  puts "**Note** Rails is not available. Type `gem install rails` to install rails."
  exit
end

require 'ramix/app_generator'