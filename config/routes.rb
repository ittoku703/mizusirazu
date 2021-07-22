Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#root'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'

  devise_for :users, path: '', controllers: { omniauth_callbacks: "omniauth_callbacks" },
    path_names: { sign_in: 'login', sign_out: 'logout', edit: 'settings' }, 
    skip: [:registrations] 
  as :user do
    get    '/signup/cancel', to: 'devise/registrations#cancel', as: :cancel_user_registration
    get    '/settings', to: 'devise/registrations#edit',        as: :edit_user_registration
    get    '/signup', to: 'devise/registrations#new',           as: :new_user_registration
    post   '/users', to: 'devise/registrations#create',         as: :user_registration
    patch  '/users', to: 'devise/registrations#update'
    put    '/users', to: 'devise/registrations#update'
    delete '/users', to: 'devise/registrations#destroy'
  end
  get '/user', to: 'static_pages#user'
end
