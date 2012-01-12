require 'ramix/templates/template'

module Ramix
  class Source < Template

    # The newest version of source template
    def self.newest_version
      'http://rubygems.org'
    end

    # The description of source template
    def self.desc
      'Special the source path of Gemfile.'
    end

    # The aliases of source template
    def aliases
      '-S'
    end

    # Output the source content
    def output
      gsub_file 'Gemfile', "source 'http://rubygems.org'", "source '#{@version}'"
      super
    end

  end
end