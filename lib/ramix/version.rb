module Ramix
  module VERSION #:nodoc:
    MAJOR = 0
    MINOR = 1
    TINY  = 2
    PRE   = nil

    STRING = [MAJOR, MINOR, TINY, PRE].compact.join('.')
  end
end