---
name: 'nosql'
aliases: '-n'
desc: 'Preconfigure for selected nosql database (options: mongoid/).'
dependence: ['-O']
type: 'string'
default: false
group: 'nosql'
---

case @nosql
when 'mongoid'
  say_wizard "Install mongoid gem"
  case rails_version
  when /3.0/ then gem 'mongoid', '2.2.5'
  when /3.1/, /3.2/ then gem 'mongoid', '2.4.3'
  end

  gem 'bson_ext', '1.5.2'

  after_bundler do
    say_wizard "Generate mongoid config file and remove database.yml"
    generate 'mongoid:config'
    remove_file 'config/database.yml'
  end
end