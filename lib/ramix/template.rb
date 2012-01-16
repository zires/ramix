require 'yaml'

module Ramix
  class Template

		DIR_PATH  = File.expand_path(File.dirname(__FILE__) + '/../../recipes')
		ATTRIBUTE = %w(description dependence default aliases)

  	attr_reader :name, :output

  	def initialize(name, path = nil)
  		@name = name
  		begin
				draft, attribute, @output = File.read( File.join(DIR_PATH, name + '.rb') ).split('---')
				@attribute                = YAML.load(attribute)
  		rescue Exception => e
				@attribute, @output = {}, "\n\ngem '#{name}'"
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
    
    def output
    	"# >====================== [#{name}] =======================<" + @output
    end

  end
end