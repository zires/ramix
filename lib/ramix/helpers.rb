module Ramix
  # A set of helper methods will append to template
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