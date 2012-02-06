---
name: 'auth'
aliases: '-a'
desc: 'Preconfigure for selected authentication(options: devise/).'
type: 'string'
default: 'devise'
group: 'authentication'
---

case @auth
when 'devise'
	say_wizard "Install devise gem"
	case rails_version
	when /3.0/ then gem 'devise', '~> 1.5.3'
	when /3.1/ then gem 'devise', '>= 2.0.0'
	end

	after_bundler do
  	say_wizard "Run devise install generator"
  	generate 'devise:install'
  	say_wizard "Run devise model generator USER"
  	generate "devise user"
	end
end