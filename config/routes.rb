Rails.application.routes.draw do
  devise_for :users
  root "recipes#index"

  resources :users, only: [:show] do
    resources :profiles, only: [:new, :create]
    resources :present_orders, only: [:new, :create]
    resources :follows, only: [:index, :create]
  end

  resources :recipes, only: [:index, :new, :create, :show] do
    resources :clips, only: [:create]
    resources :comments, only: [:create] 

    collection do
      get 'search'
    end
  end
end
