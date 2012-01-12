require 'ramix/templates/template'

module Ramix
  class Mongoid < Template

    # The newest version of mongoid
    def self.newest_version
      '2.3.4'
    end

    # The description of mongoid
    def self.desc
      'Mongoid is an ODM (Object Document Mapper) Framework for MongoDB, written in Ruby.'
    end

    # The dependence of mongoid
    def self.dependence
      "-O"
    end

    # Output the template of mongoid
    def output
      case rails_version
      when /3.0/ then gem_below_31
      when /3.1/ then gem_above_31
      end
      run 'bundle install'
      generate 'mongoid:config'
      remove_file 'config/database.yml'
      super
    end

    private

    def gem_below_31
      gem 'bson_ext', '1.5.2'
      gem 'mongoid', '2.0.2'
    end

    def self.gem_above_31
      gem 'bson_ext', '1.5.2'
      gem 'mongoid', newest_version
    end

  end
end