Rails.application.routes.draw do
  root 'application#hello'

  resources :users, except: %i[new edit]

  get 'signup', to: 'users#new', as: 'new_user'
  get 'settings', to: 'users#edit', as: 'edit_user'
  get 'users/:id/activate', to: 'users#activate', as: 'activate_user'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
end
