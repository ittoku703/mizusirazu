Rails.application.routes.draw do
  root 'home#home'
  devise_for :users, path: '/', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    password: 'password',
    confirmation: 'confirmation',
    sign_up: 'signup',
    edit: 'settings',
    unlock: 'unlock'
  }
end
