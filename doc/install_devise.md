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

## add devise controllers

`rails generate devise:controllers users`

Usage: https://github.com/heartcombo/devise#configuring-controllers

## changed devise routing

config/routes.rb

```ruby
devise_for :users, path: '', path_names: { 
  sign_in: 'login', sign_out: 'logout', 
  password: 'password', 
  confirmation: 'verification', unlock: 'unblock', 
  registration: '', sign_up: 'signup', edit: 'settings' 
}
```

## customize I18n

### set default locale

config/application.rb

```ruby
config.i18n.default_locale = :ja
```

### add locale file

config/locales/devise.ja.yml

See: https://gist.github.com/satour/6c15f27211fdc0de58b4

### add rails-i18-n to gem

Gemfile

```ruby
gem 'rails-i18n',  '~> 6.0'
```

## add Test (RSpec)

### add rexml (Necessaly to use rspec)

```ruby
gem 'rexml', '~> 3.2', '>= 3.2.5'
```

### add guard-rspec

```ruby
gem 'guard-rspec', '~> 4.7', '>= 4.7.3', require: false
```

run `bundle exec guard init rspec`

