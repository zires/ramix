---
name: 'lang'
aliases: '-l'
desc: 'Preconfigure for selected template language(options: haml/slim/).'
type: 'string'
group: 'template language'
default: false
---

case @lang
when 'haml'
  say_wizard "Install haml gem"
  gem "haml-rails"
  after_everything do
    say_wizard "Covert erb to haml"
    inside('app/views/layouts') do
      run('html2haml -e application.html.erb application.haml')
    end
  end
when 'slim'
  say_wizard "Install slim gem"
  # gem "slim-rails"
  # TODO slim may have some problems. replace application.html.erb to application.slim
end