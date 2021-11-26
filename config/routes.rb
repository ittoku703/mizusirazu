Rails.application.routes.draw do
  root 'home#home'
  devise_for :users, path: '/', controllers: {
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks'
  }, path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    password: 'password',
    confirmation: 'confirmation',
    registration: 'users',
    unlock: 'unlock'
  }

  devise_scope :user do
    get '/signup', to: 'users/registrations#new', as: 'user_signup'
    get '/settings', to: 'users/registrations#edit', as: 'user_settings'
    get '/users/:id', to: 'users/registrations#show', as: 'user_profile'
  end

  get '/users/:id/microposts', to: 'microposts#user_microposts', as: 'user_microposts'

  resources :microposts do
    resources :comments, only: %i[create update destroy]
  end
end
