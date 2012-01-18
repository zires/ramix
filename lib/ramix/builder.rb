require 'ramix/helpers'

module Ramix

  # Ramix::Builder be responsible for adding some useful methods on the top or the bottom of template.
  # 
  class Builder

    def initialize(default_template_path = nil, &block)
      @template_path = default_template_path || tempfile_path
      @import = []
      instance_eval(&block) if block_given?
    end

    def import(template, *args)
      @import << proc { template.output(*args) }
    end

    # run method accept content for creating template.
    # It return a template path
    #
    def run
      begin
        File.open(@template_path, "a+") do |file|
          file.write rails_version
          file.write callback_functions
          @import.each{ |template|  file.write template.call }
          file.write callbacks
        end
      rescue Exception => e
        puts "Create template #{@template} error~~ #{e}"
      end
      @template_path
    end

    private

    def tempfile_path
      require 'tempfile'
      Tempfile.new('template').path
    end

    include Ramix::Helpers

  end
  
end