---
name: 'china'
aliases: '-c'
desc: 'Special the chinese source path of Gemfile.'
type: 'boolean'
default: false
group: 'source'
---
say_wizard "Replace gemfile source"
gsub_file 'Gemfile', "source 'http://rubygems.org'", "source 'http://ruby.taobao.org/'"