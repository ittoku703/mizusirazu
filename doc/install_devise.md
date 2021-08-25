## add devise to Gem

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

## add User model

`rails g devise User`

### add name columns

20210826______devise_create_users.rb

```ruby
t.string :name, null: false, default: ""
add_index :users, :name, unique: true
```

### add strong parameter

app/controllers/application_controller.rb

```ruby
before_action :configure_permitted_parameters, if: :devise_controller?

protected
	
	def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, key: [:name])
  end
```

## add devise views

`rails generate devise views users`

### use users directory on views

config/initializers/devise.rb

```ruby
config.scoped_views = true
```

