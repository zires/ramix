---
name: 'mongoid'
description: 'Mongoid is an ODM (Object Document Mapper) Framework for MongoDB, written in Ruby.'
dependence: ['-O']
---

case rails_version
when /3.0/
	gem 'mongoid', '2.0.2'
when /3.1/
	gem 'mongoid', '2.3.4'
end

gem 'bson_ext', '1.5.2'

after_bundler do
	generate 'mongoid:config'
  remove_file 'config/database.yml'
end