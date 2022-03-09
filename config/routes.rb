Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'users#index'

  get    '/signup', to: 'users#new', as: 'new_user'
  get    '/login', to: 'sessions#new', as: 'new_session'
  delete '/logout', to: 'sessions#destroy', as: 'session'

  get '/auth/twitter/callback', to: 'providers#twitter', as: 'twitter_callback'
  get '/auth/github/callback', to: 'providers#github', as: 'github_callback'
  get '/auth/failure', to: 'providers#failure', as: 'provider_failure'

  scope :settings do
    get '/user', to: 'users#edit', as: 'edit_user'
    get '/profile', to: 'profiles#edit', as: 'edit_user_profile'
  end

  resources :users, except: %i[new], param: :name do
    resources :profiles, only: %i[update]
  end

  resources :sessions, only: %i[create]
  resources :account_activations, only: %i[new create edit], path: :confirms
  resources :password_resets, only: %i[new create edit update], path: :passwords
end
