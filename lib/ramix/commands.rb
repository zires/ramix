if ARGV.first == "new"
  ARGV.shift
end
require 'ramix'
Ramix::AppGenerator.start