---
name: 'home'
aliases: '-H'
desc: 'Generate a home controller and view.'
type: 'string'
default: 'home'
group: 'general'
---
say_wizard "Remove static files: index.html, rails.png"
remove_file 'public/index.html'

case rails_version
when /3.0/ then remove_file 'public/images/rails.png'
when /3.1/, /3.2/ then remove_file 'app/assets/images/rails.png'
end

after_bundler do
  say_wizard "Generate #{@home} controller"
  generate :controller, "#{@home} index"
  gsub_file 'config/routes.rb', /get \"#{@home}\/index\"/, %Q(root :to => "#{@home}#index")
end

#DEPRECATION WARNING: ActiveSupport::Memoizable is deprecated and will be removed in future releases,simply use Ruby memoization pattern instead. (called from <top (required)> at /mnt/projects/ruby-china/config/application.rb:13)
#:public is no longer used to avoid overloading Module#public, use :public_folder instead
#  from /home/zires/.rvm/gems/ruby-1.9.3-preview1/gems/resque-1.19.0/lib/resque/server.rb:12:in `<class:Server>'
