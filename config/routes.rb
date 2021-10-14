Rails.application.routes.draw do
  root 'application#hello'

  resources :users do
    member do
      get :activate
    end
  end

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
end
