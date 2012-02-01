ARGV << '--help' if ARGV.empty?

# The first argument must be 'new' else return the help message.
if ARGV.first == "new"
  ARGV.shift
else
	ARGV.clear
  ARGV << '--help'
end

require 'ramix'
Ramix::AppGenerator.start