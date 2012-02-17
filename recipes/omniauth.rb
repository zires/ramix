---
name: 'omniauth'
aliases: '-A'
desc: 'OmniAuth is a flexible authentication system utilizing Rack middleware.'
type: 'array'
group: 'authentication'
default: ['google', 'facebook', 'twitter']
order: 3
---

if @omniauth == ['china']
  @omniauth = ['weibo', 'renren', 'douban', 'qzone']
end

say_wizard "Install omniauth gem"
gem 'omniauth'

@omniauth.each do |stratege|
  say_wizard "Install omniauth #{stratege} gem"
  case stratege
  when 'renren'
    gem "omniauth-renren", "~> 1.0.0.rc2.1"
  else
    gem "omniauth-#{stratege}"
  end
end

after_bundler do
  
  case @auth
  # For devise
  when 'devise'
    gsub_file 'app/models/user.rb', /:recoverable, :rememberable, :trackable, :validatable/, ':recoverable, :rememberable, :trackable, :validatable, :omniauthable'
    
    insert_into_file 'config/initializers/devise.rb', :before => "# config.omniauth :github, 'APP_ID', 'APP_SECRET', :scope => 'user,public_repo'\n" do
      @omniauth.map do |stratege|
        " config.omniauth :#{stratege}, 'APP_ID', 'APP_SECRET', :scope => 'user,public_repo'"
      end.join("\n")<<("\n")
    end
  else
    # For general install
    insert_into_file "app/views/layouts/application.html.erb", :before => "<%= yield %>\n" do
      @omniauth.inject('') do |str, stratege|
        str << "<%= link_to 'Sign in with #{stratege}', user_omniauth_authorize_path(:#{stratege}) %> "
      end << "\n"
    end
  end

end