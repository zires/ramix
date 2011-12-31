require 'rubygems' #TODO ruby1.9 do not need require rubygems
begin
  require 'rails/generators'
	require 'rails/generators/rails/app/app_generator'
rescue LoadError
  puts "*Note* Rails is not available. Type `gem install rails` to install rails"
end
require 'ramix/app_generator'

if ARGV.first == "new"
	ARGV.shift
end
Ramix::AppGenerator.start