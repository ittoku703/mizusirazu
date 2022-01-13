Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'articles#index'
  get  '/signup', to: 'users#new', as: 'new_user'

  resources :users, except: %i[new], param: :name do
    resources :profiles, only: %i[index update]
  end
end
