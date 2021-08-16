Rails.application.routes.draw do
  devise_for :users
  root "recipes#index"
  resources :users, only: [:show]
end
