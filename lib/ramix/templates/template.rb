require 'active_support/inflector'

module Ramix
  class Template
    COMMANDS = [ :gem, :run, :generate, :remove_file, :gsub_file, :inject_into_file ]
    #@@commands = [ "apply", "run", "gem", "generate", "initializer", "remove_file", "inject_into_file", "gsub_file", "file" ]
    #COMMANDS = [ 'gem', 'run', 'generate', 'remove_file', 'gsub_file', 'inject_into_file' ]
    attr_reader :name, :version, :rails_version, :output_buffer

    def initialize(rails_version = nil)
      @name          = self.class.name.split('::').pop.underscore
      @rails_version = rails_version
      @version       = self.class.newest_version
      @output_buffer = "# >====================== [#{@name}] =======================< \n\n"
    end

    # Output the template content
    def output
      output_buffer
    end

    class << self

      # The newest version of template
      def newest_version;'';end

      # The description of template
      def desc;'';end

      # The dependence of template
      def self.dependence;'';end

      # The aliases of template
      def aliases;nil;end

    end

    private

    # Generate a lot of methods, those methods just print their arguments
    # :gem, :run, :generate, :remove_file, :gsub_file, :inject_into_file
    # 
    COMMANDS.each do |command|
      define_method(command) do |*args|
        params = args.map do |arg|
          case arg
          when String, Hash then arg.inspect
          else "#{arg}"
          end
        end.join(',')
        output_buffer << (command.to_s + ' ' + params + "\n\n")
      end
    end

  end
end