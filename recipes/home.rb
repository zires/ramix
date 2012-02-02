---
name: 'home'
desc: 'Generate a home controller and view.'
type: 'string'
default: 'home'
---

remove_file 'public/index.html'

case rails_version
when /3.0/ then remove_file 'public/images/rails.png'
when /3.1/ then remove_file 'app/assets/images/rails.png'
end

after_bundler do
	generate :controller, "#{@home} index"
	gsub_file 'config/routes.rb', /get \"#{@home}\/index\"/, %Q(root :to => "#{@home}#index")
end
