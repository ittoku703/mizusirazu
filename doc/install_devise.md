### add devise to Gem

```ruby
gem 'devise', '~> 4.8'
```

### set default_url_options to development.rb

```ruby
config.action_mailer.default_url_options = { host: 'localhost', port: 5000 }
```

### add notification

layouts/_notification.html.erb

```erb
<% flash.each do |key, value| %>
  <%= content_tag(:div, "test", class: "notification notification__notice") %>
<% end %>
```

