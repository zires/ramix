module Ramix
  module Templates
    class Builder

      def initialize(default_template = nil, &block)
        @import = []

        if default_template.nil?
          require 'tempfile'
          default_template = Tempfile.new('template').path
        end

        @template = default_template

        instance_eval(&block) if block_given?
      end

      def import(template, rails_version = nil)
        @import << proc { template.new(rails_version) }
      end

      # Generate the template file path
      def run
        begin
          File.open(@template, "a+") do |file|
            @import.each{ |template|  file.write template.call.output }
          end
        rescue Exception => e
          puts "Create template #{@template} error~"
        end
        @template
      end

    end
  end
end