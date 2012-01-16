---
name: 'source'
description: 'Special the source path of Gemfile.'
default: 'http://rubygems.org'
---

gsub_file 'Gemfile', "source 'http://rubygems.org'", "source '#{@source}'"