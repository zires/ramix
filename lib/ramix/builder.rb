require 'ramix/helpers'

module Ramix

  # Ramix::Builder be responsible for adding some useful methods on the top or the bottom of template.
  class Builder

    def initialize(default_template_path = nil, &block)
      @template_path = default_template_path || tempfile_path
      @import        = []
      instance_eval(&block) if block_given?
    end

    def import(template, *args)
      @import << [template.order, proc { template.output(*args) }]
    end

    # Write some useful methods and the content of recipe in the file.
    # Return the path of the template.
    def run
      begin
        File.open(@template_path, "a+") do |file|
          file.write preparation_methods
          file.write rails_version
          file.write callback_functions
          ordered_templates.each{ |template|  file.write template[1].call }
          file.write before_callbacks
          file.write callbacks
        end
      rescue Exception => e
        puts "Create template #{@template} error~~ #{e.message}"
      end
      @template_path
    end

    private

    def tempfile_path
      require 'tempfile'
      Tempfile.new('template').path
    end

    def ordered_templates
      @import.sort_by{ |t| t[0] }
    end

    include Ramix::Helpers

  end
  
end