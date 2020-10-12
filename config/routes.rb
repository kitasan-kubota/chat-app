Rails.application.routes.draw do
  devise_for :users
  get 'messages/index'
  root to: "messages#index"
  resources :users
  resources :rooms, only: [:new, :create]
end
