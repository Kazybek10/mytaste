Rails.application.routes.draw do
  get 'home/index'
  get 'recipes/index'
  get 'recipes/show'
  get 'recipes/new'
  get 'recipes/create'
  get 'recipes/edit'
  get 'recipes/update'
  get 'recipes/destroy'
  get 'books/index'
  get 'books/show'
  get 'books/new'
  get 'books/create'
  get 'books/edit'
  get 'books/update'
  get 'books/destroy'
  get 'movies/index'
  get 'movies/show'
  get 'movies/new'
  get 'movies/create'
  get 'movies/edit'
  get 'movies/update'
  get 'movies/destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :movies
  resources :books
  resources :recipes

  # Defines the root path route ("/")
  root "home#index"

  # root "posts#index"
end
