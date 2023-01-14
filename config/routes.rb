Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  devise_for :users
  root to: "home#index"
  resources :users do
    member do
      get :followings
      get :followers
    end
  end
  
  resources :items
  resources :relationships, only: [:create, :destroy]
 
end
