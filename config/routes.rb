Rails.application.routes.draw do
  devise_for :users
  root to: "rooms#index"
  resources :users
  resources :rooms, only: [:new, :create, :index, :destroy] do
    resources :messages, only: [:index, :create]
  end
end
