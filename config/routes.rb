Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users

  resources :movies
  resources :books
  resources :recipes

  root "home#index"
end
