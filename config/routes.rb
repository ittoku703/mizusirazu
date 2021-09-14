Rails.application.routes.draw do
  root 'static_pages#welcome'
  devise_for :users, controllers: { confirmations: 'users/confirmations', registrations: 'users/registrations' }, path: '',
                     path_names: { sign_in: 'login', sign_out: 'logout',
                                   password: 'password',
                                   confirmation: 'verification',
                                   unlock: 'unlock',
                                   registration: '',
                                   sign_up: 'signup',
                                   edit: 'settings' }
  devise_scope :user do
    get '/user', to: 'users/registrations#show'
  end
end
