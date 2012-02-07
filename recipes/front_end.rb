---
name: 'front'
aliases: '-F'
desc: 'Preconfigure for selected front-end template or plugin(options: bootstrap/h5bp/).Note that h5bp refer to html5-boilerplate.'
type: 'string'
default: 'bootstrap'
group: 'front-end'
---
case @front
when "bootstrap"
  case rails_version
  when /3.1/, /3.2/
    say_wizard "Install twitter-bootstrap-rails gem"
    gem 'twitter-bootstrap-rails', :git => 'http://github.com/seyhunak/twitter-bootstrap-rails.git'
    after_bundler do
      say_wizard "Run twitter-bootstrap-rails install generator"
      generate 'bootstrap:install'
    end
  end
end