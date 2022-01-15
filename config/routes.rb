Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'articles#index'

  get    '/signup', to: 'users#new', as: 'new_user'
  get    '/login', to: 'sessions#new', as: 'new_session'
  delete '/logout', to: 'sessions#destroy', as: 'session'

  resources :users, except: %i[new], param: :name do
    resources :profiles, only: %i[index update]
  end

  resources :sessions, only: %i[create]
end
