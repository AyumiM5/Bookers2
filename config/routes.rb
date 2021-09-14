Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  
  resources :books, only: [:new, :create, :edit, :update, :index, :show, :destroy]
  
end
