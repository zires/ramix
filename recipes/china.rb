---
name: 'china'
desc: 'Special the chinese source path of Gemfile.'
type: 'boolean'
---

gsub_file 'Gemfile', "source 'http://rubygems.org'", "source 'http://ruby.taobao.org/'"