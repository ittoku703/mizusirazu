Rails.application.routes.draw do
  root 'home#home'
  devise_for :users, path: '/', controllers: {
    confirmations: 'confirmations',
    passwords: 'passwords',
    registrations: 'registrations',
    sessions: 'sessions',
    unlocks: 'unlocks'
  }, path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    password: 'password',
    confirmation: 'confirmation',
    registration: 'users',
    unlock: 'unlock'
  }

  devise_scope :user do
    get '/signup', to: 'registrations#new'
    get '/settings', to: 'registrations#edit'
    get '/users/:id', to: 'registrations#show', as: 'user_profile'
  end

  get '/users/:id/microposts', to: 'microposts#user_microposts', as: 'user_microposts'

  resources :microposts do
    resources :comments, only: %i[create update destroy]
  end
end
