Rails.application.routes.draw do
  
  devise_for :users
  
  root to: "home#index"
  resources :users do
    member do
      get :followings
      get :followers
      get :favorites
    end
  end
  
  resources :items 
  resources :favorites, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
 
end
