---
name: 'devise'
desc: 'Flexible authentication solution for Rails with Warden.'
type: 'string'
default: 'user'
---

say_wizard "Install devise gem"
case rails_version
when /3.0/ then gem 'devise', '~> 1.5.3'
when /3.1/ then gem 'devise', '>= 2.0.0'
end

after_bundler do
  say_wizard "Run devise install generator"
  generate 'devise:install'
  say_wizard "Run devise model generator #{@devise}"
  generate "devise #{@devise}"
end