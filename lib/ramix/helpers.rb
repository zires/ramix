module Ramix
  # A set of helper methods will append to the template
  module Helpers
    
    def preparation_methods
      <<-TEMPLATE
      def say_wizard(text)
        say "******" + text + "******"
      end
      TEMPLATE
    end

    def rails_version
      <<-TEMPLATE
        # Check the version of your rails gem
        # Only support above 3.0
        def rails_version
          [Rails::VERSION::MAJOR, Rails::VERSION::MINOR].join('.')
        end
      TEMPLATE
    end

    def callback_functions
      <<-TEMPLATE
        @after_bundler_blocks = []
        def after_bundler(&block)
          @after_bundler_blocks << block
        end
        @after_everything_blocks = []
        def after_everything(&block)
          @after_everything_blocks << block
        end
        TEMPLATE
    end

    def before_callbacks
      <<-TEMPLATE
        if File.exist?('config/initializers/wrap_parameters.rb') and RUBY_VERSION < '1.9'
          gsub_file 'config/initializers/wrap_parameters.rb', "wrap_parameters format: [:json]", "wrap_parameters format => [:json]"
        end

        # WARNING: This version of mysql2 (0.3.11) doesn't ship with the ActiveRecord adapter bundled anymore as it's now part of Rails 3.1
        # WARNING: Please use the 0.2.x releases if you plan on using it in Rails <= 3.0.x
        case rails_version
        when /3.0/
          gsub_file 'Gemfile', "gem 'mysql2'", "gem 'mysql2', '~>0.2.18'"
        end

        # Use unicorn as the web server
        say_wizard('Use unicorn as the web server')
        gsub_file 'Gemfile', "# gem 'unicorn'", "gem 'unicorn'"
      TEMPLATE
    end

    def callbacks
      <<-TEMPLATE
        say_wizard 'Install bundle'
        run 'bundle install'
        @after_bundler_blocks.each{ |b| b.call }
        @after_everything_blocks.each{ |b| b.call }
      TEMPLATE
    end
      
  end

end