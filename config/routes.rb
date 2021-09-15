Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  
  resources :books, only: [:new, :create, :edit, :update, :index, :show, :destroy]
  resources :users, only: [:show, :edit, :update, :index]
  
end
