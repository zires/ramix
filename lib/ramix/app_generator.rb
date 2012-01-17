require 'ramix/template'
require 'ramix/builder'

module Ramix
  class AppGenerator < Thor::Group

    argument :app_path, :type => :string
    
    Dir.entries(Ramix::Template::DIR_PATH).each do |name|
      next unless name =~ /.rb/
      name = File.basename(name, '.rb')
      template          = Ramix::Template.new(name)
      options           = { :group => :ramix }
      Ramix::Template::THOR_CLASS_OPTION.each do |opt|
        options[opt.to_sym] = template.send(opt)
      end
      send 'class_option', name.to_sym, options
    end
                                        
    # Overwrite class options help. Merge class options form rails
    def self.class_options_help(shell, groups={})
      Rails::Generators::AppGenerator.class_options_help( Thor::Shell::Basic.new )
      super(Thor::Shell::Basic.new, groups) #TODO - use color shell
    end

    def initialize(args, options, config)
      raise Thor::Error, "Application path should be given. For details run: ramix --help" if args[0].blank?
      #options << "-m"
      #options << build_template(options)
      super
      # Invoke the rails application generator
      invoke Rails::Generators::AppGenerator
    end
    
    protected

    def self.banner#:nodoc:
      "ramix new APP_PATH [options]"
    end
    
    # According to the options build template
    def build_template(options)
      Ramix::Builder.new do
        format_options(options.dup).each do |name, args|
          import name, args
        end
      end.run
    end

    # Example:
    # format_options(['-f','--mongoid','-S','http://rubygems.org', 'http://rubycutter.com'])
    #   #=> { 'f' => nil, 'mongoid' => nil, 'S' => ['http://rubygems.org', 'http://rubycutter.com'] }
    #
    def format_options(options)
      opts, last_opt = Hash.new { |h,v| h[v] = [] } , nil
      options.each do |opt|
        if opt =~ /^-{1,2}(.+)/
          opt[$1]  = nil
          last_opt = $1
        else
          opt[last_opt] << opt
        end
      end
      opts
    end

  end
end