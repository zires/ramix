---
name: 'source'
desc: 'Special the source path of Gemfile.'
default: 'http://rubygems.org'
aliases: '-S'
type: 'string'
---

gsub_file 'Gemfile', "source 'http://rubygems.org'", "source '#{@source}'"