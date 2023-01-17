Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
  get 'relationships/create'
  get 'relationships/destroy'
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
  post 'favorite/:id' => 'favorites#create', as: 'create_favorite'
  delete 'favorite/:id' => 'favorites#destroy', as: 'destroy_favorite'
  resources :relationships, only: [:create, :destroy]
 
end
