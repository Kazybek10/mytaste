Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users

  resources :movies
  resources :books
  resources :recipes

  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create]
  delete "/logout", to: "sessions#destroy", as: :logout
  get "/signup", to: "users#new", as: :signup
  get "/login", to: "sessions#new", as: :login

  root "home#index"
end
