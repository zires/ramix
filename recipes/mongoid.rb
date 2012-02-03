---
name: 'mongoid'
desc: 'Mongoid is an ODM (Object Document Mapper) Framework for MongoDB, written in Ruby.'
dependence: ['-O']
type: 'boolean'
default: false
---
say_wizard "Install mongoid gem"
case rails_version
when /3.0/ then gem 'mongoid', '2.2.5'
when /3.1/ then gem 'mongoid', '2.4.3'
end

gem 'bson_ext', '1.5.2'

after_bundler do
	say_wizard "Generate mongoid config file and remove database.yml"
  generate 'mongoid:config'
  remove_file 'config/database.yml'
end