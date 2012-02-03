require 'yaml'

module Ramix
  class Template

    DIR_PATH          = File.expand_path(File.dirname(__FILE__) + '/../../recipes')
    THOR_CLASS_OPTION = %w(desc required default aliases type banner)
    SELF_ATTRIBUTE    = %w(dependence)
    ATTRIBUTE         = THOR_CLASS_OPTION + SELF_ATTRIBUTE

    def initialize(name, path = nil)
      @name = name
      @path = path || DIR_PATH
      begin
        draft, attribute, @output = File.read( File.join(@path, name + '.rb') ).split('---')
        @attribute                = YAML.load(attribute)
      rescue
        @attribute, @output       = {}, "\n\ngem '#{name}'"
      end
    end

    def name
      @attribute['name'] || @name
    end

    ATTRIBUTE.each do |attr|
      class_eval <<-RUBY
        def #{attr}
          @attribute['#{attr}']
        end
      RUBY
    end

    def output(*args)
      args = args.join if type == 'string' or type == nil
      out_buffer = "# >====================== [#{name}] =======================<\n\n"
      out_buffer << "instance_variable_set '@#{name}', '#{args}'\n\n" if args
      <<-TEMPLATE
      #{out_buffer}
      #{@output}
      TEMPLATE
    end

  end
end