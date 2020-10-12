Rails.application.routes.draw do
  devise_for :users
  get 'rooms/index'
  root to: "messages#index"
  resources :users
  resources :rooms, only: [:new, :create, :index]
end
