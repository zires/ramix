require 'thor/group'
require 'ramix/templates'
require 'ramix/templates/builder'
require 'ramix/template'

module Ramix
  class AppGenerator < Thor::Group
    
    Dir.entries(Ramix::Template::DIR_PATH).each do |name|
      next unless name =~ /.rb/
      name = File.basename(name, '.rb')
      template          = Ramix::Template.new(name)
      options           = { :type => :string, :group => :ramix }
      options[:aliases] = template.aliases if template.aliases
      options[:desc]    = template.description if template.description
      options[:default] = template.default if template.default
      send 'class_option', name.to_sym, options
    end
                                        
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
      end.run
    end

  end
end