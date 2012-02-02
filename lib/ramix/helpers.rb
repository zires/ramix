module Ramix
  # A set of helper methods will append to the template
  module Helpers
    
    def rails_version
      <<-TEMPLATE
        # Check the version of your rails gem
        # Only support above 3.0
        def rails_version
          [Rails::VERSION::MAJOR, Rails::VERSION::MINOR].join('.')
        end
      TEMPLATE
    end

    def ruby_version
      <<-TEMPLATE
        # Check the version of ruby
        gsub_file 'config/initializers/wrap_parameters.rb', "wrap_parameters format: [:json]", "wrap_parameters format => [:json]" if RUBY_VERSION < '1.9'
      TEMPLATE
    end

    def callback_functions
      <<-TEMPLATE
        @after_bundler_blocks = []
        def after_bundler(&block)
          @after_bundler_blocks << block
        end
        TEMPLATE
    end

    def callbacks
      <<-TEMPLATE
        run 'bundle install'
        @after_bundler_blocks.each{ |b| b.call }
      TEMPLATE
    end
      
  end

end