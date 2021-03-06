require 'ramix/template'
require 'ramix/builder'

module Ramix
  class AppGenerator < Thor::Group

    argument :app_path, :type => :string

    @@templates = {}

    Dir.entries(Ramix::Template::DIR_PATH).each do |name|
      next unless name           =~ /.rb$/
      name                       = File.basename(name, '.rb')
      template                   = Ramix::Template.new(name)
      @@templates[template.name] = template
      options                    = {}

      Ramix::Template::THOR_CLASS_OPTION.each do |opt|
        options[opt.to_sym] = template.send(opt)
      end
      
      send 'class_option', template.name.to_sym, options
      unless template.type == "boolean" or template.default == false
        send 'class_option', "skip_#{template.name}".to_sym, :type => :boolean, :default => false, :desc => "Don't use #{template.name} option.", :group => template.group
      end
    end

    # Overwrite class options help. Merge class options form rails
    def self.class_options_help(shell, groups={})
      Rails::Generators::AppGenerator.class_options_help( Thor::Shell::Basic.new )
      super(Thor::Shell::Basic.new, groups) #TODO - use color shell
    end

    def initialize(args, opts, config)
      raise Thor::Error, "Application path should be given. For details run: ramix --help" if args[0].blank?
      super
      add_template_option opts, options
      # Invoke the rails application generator
      invoke Rails::Generators::AppGenerator
    end
    
    protected

    def self.banner#:nodoc:
      "ramix new APP_PATH [options]"
    end
    
    # According to the options and class_options to build template
    def build_template(opts, class_options)
      Ramix::Builder.new do
        class_options.each { |name, args| import @@templates[name], args unless @@templates[name].nil? or class_options["skip_#{name}".to_sym] }
      end.run
    end

    # Add '-m' #{template} in the ARGV
    def add_template_option(opts, class_options)
      insert_dependence_options(opts, class_options)
      opts << '-m'
      opts << build_template(opts, class_options)
    end

    # if the template recipe has some dependence options then add these into the opts.
    def insert_dependence_options(opts, class_options)
      class_options.each do |name, args|
        next if @@templates[name].nil? or @@templates[name].dependence.nil?
        @@templates[name].dependence.each{ |d| opts << d }
      end
    end

  end
end