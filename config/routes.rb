Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users

  resources :movies
  resources :books
  resources :recipes

  get '/search', to: 'search#index'

  root "home#index"
end
