module Ramix
	module Templates
		class	Builder

			def initialize(default_template = nil, &block)
      	@import, @run = [], default_template
      	instance_eval(&block) if block_given?
    	end

    	def import(template, rails_version = nil)
        @import << proc { |app| template.new(rails_version) }
    	end

		end
	end
end