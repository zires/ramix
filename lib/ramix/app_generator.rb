require 'thor/group'
require 'ramix/templates'
require 'ramix/templates/builder'

module Ramix
	class AppGenerator < Thor::Group
    
    class_option :source,           :type => :string, :aliases =>  Ramix::Source.aliases, :group => :ramix, :default => Ramix::Source.newest_version,
                                    :desc => Ramix::Source.desc
    class_option :mongoid,          :type => :string, :group => :ramix, :default => Ramix::Mongoid.newest_version,
                                    :desc => Ramix::Mongoid.desc
                                        
    # Overwrite class options help. Merge class options form rails
    def self.class_options_help(shell, groups={})
      Rails::Generators::AppGenerator.class_options_help( Thor::Shell::Basic.new )
      super(Thor::Shell::Basic.new, groups) #TODO - use color shell
    end

    def initialize(args, options, config)
      raise Thor::Error, "Application path should be given. For details run: ramix --help" if args[0].blank?
      options << "-m"
      options << build_template(options)
      super
      # Invoke the rails application generator
      invoke Rails::Generators::AppGenerator
    end

    protected

    def self.banner#:nodoc:
      "ramix new APP_PATH [options] \n or: ramix create TEMPLATE_PATH [options]"
    end
    
    # According to the options build template 
    def build_template(options)
      Ramix::Templates::Builder.new do
        import Ramix::Source
        import Ramix::Mongoid, Rails::VERSION::STRING
        #import :source   if ARGV.include?('--source')
        #import :mongoid  if ARGV.include?('--mongoid')
      end.run('path')
    end

  end
end