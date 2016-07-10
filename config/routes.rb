Rails.application.routes.draw do
  root 'users#index'
  devise_for :users, only: [:sessions, :registration, :passwords]
  resources :users, only: [:index] do
    member do
      post 'ban'
      post 'unban'
    end
  end
  resources :talks, only: [:index, :show, :create]
end
