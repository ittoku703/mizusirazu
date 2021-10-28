Rails.application.routes.draw do
  root 'home#home'
  devise_for :users, path: '/', controllers: {
    registrations: 'registrations',
    confirmations: 'confirmations'
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
end
