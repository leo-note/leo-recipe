Rails.application.routes.draw do
  devise_for :users
  root "recipes#index"
  resources :users, only: [:show] do
    resources :profiles, only: [:new, :create]
  end

  resources :recipes, only: [:index, :new, :create, :show] do
    collection do
      get 'search'
    end
  end
end
