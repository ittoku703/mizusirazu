Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#root'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  get  '/user', to: 'static_pages#user'
end
