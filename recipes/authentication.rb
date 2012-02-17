---
name: 'auth'
aliases: '-a'
desc: 'Preconfigure for selected authentication(options: devise/).'
type: 'string'
default: 'devise'
group: 'authentication'
order: 2
---

case @auth
when 'devise'
  say_wizard "Install devise gem"
  case rails_version
  when /3.0/ then gem 'devise', '~> 1.5.3'
  when /3.1/, /3.2/ then gem 'devise', '>= 2.0.0'
  end

  after_bundler do
    say_wizard "Run devise install generator"
    generate 'devise:install'

    say_wizard "Run devise model generator USER"
    generate "devise user -f"
    # Ensure you have flash messages in app/views/layouts/application.html.erb.
    # For example:
    #   <p class="notice"><%= notice %></p>
    #   <p class="alert"><%= alert %></p>
    insert_into_file "app/views/layouts/application.html.erb", :before => "<%= yield %>\n" do
<<-INSERT
<p class="notice"><%= notice %></p>
<p class="alert"><%= alert %></p>
INSERT
    end

    # Add sign_in, sign_out, and sign_up links to your layout template
    insert_into_file "app/views/layouts/application.html.erb", :before => "<%= yield %>\n" do
<<-INSERT
<ul>
<% if user_signed_in? %>
  <li>
  <%= link_to('Logout', destroy_user_session_path, :method => :delete) %>        
  </li>
<% else %>
  <li>
  <%= link_to('Login', new_user_session_path)  %>  
  </li>
<% end %>
<% if user_signed_in? %>
  <li>
  <%= link_to('Edit registration', edit_user_registration_path) %>
  </li>
<% else %>
  <li>
  <%= link_to('Register', new_user_registration_path)  %>
  </li>
<% end %>
</ul>
INSERT
    end

  end
end