Rails.application.routes.draw do
  root "static_pages#welcome"
  devise_for :users
end
