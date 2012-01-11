require 'thor/group'
require 'ramix/templates'

module Ramix
	class TemplateGenerator < Thor::Group

    
    class_option :source,           :type => :string, :aliases => "-S", :group => :ramix, :default => "http://rubygems.org",
                                    :desc => "TODO china special for china"
    class_option :mongoid,          :type => :string, :group => :ramix, :default => Ramix::Mongoid.newest_version,
                                    :desc => Ramix::Mongoid.desc
    
    def initialize(*args)
      path = args[0].first
      File.open(path, "w+") do |file|
        file.write Ramix::Mongoid.output(Rails::VERSION::STRING)
      end
    end
                                        
    protected

    def self.banner#:nodoc:
      "ramix create Template_PATH [options]"
    end
      
  end
end