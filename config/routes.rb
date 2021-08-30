Rails.application.routes.draw do
  root "static_pages#welcome"
  devise_for :users, controllers: { confirmations: 'users/confirmations' }, path: '', path_names: { sign_in: 'login', sign_out: 'logout', password: 'password', confirmation: 'verification', unlock: 'unblock', registration: '', sign_up: 'signup', edit: 'settings' }
end
