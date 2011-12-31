require 'thor/group'
require 'ramix/templates'

module Ramix
	class AppGenerator < Thor::Group

    
    class_option :source,           :type => :string, :aliases => "-S", :group => :ramix, :default => "http://rubygems.org",
                                    :desc => "TODO china special for china"
    class_option :mongoid,          :type => :string, :group => :ramix, :default => Ramix::Mongoid.newest_version,
                                    :desc => Ramix::Mongoid.desc
    class_option :devise,           :type => :string, :group => :ramix, :default => "1.5.3",
                                    :desc => "Flexible authentication solution for Rails with Warden."
    class_option :omniauth,         :type => :string, :group => :ramix, :default => "1.0.1",
                                    :desc => "OmniAuth is a flexible authentication system utilizing Rack middleware."
    
    # Overwrite class options help. Merge class options form rails
    def self.class_options_help(shell, groups={})
      Rails::Generators::AppGenerator.class_options_help( Thor::Shell::Basic.new )
      super(Thor::Shell::Basic.new, groups) #TODO - use color shell
    end

    protected

    def self.banner#:nodoc:
      "ramix new APP_PATH [options]"
    end
      
  end
end