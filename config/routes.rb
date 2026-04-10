Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users

  resources :movies do
    collection do
      get :api_search
      get :api_import
    end
  end

  resources :books do
    collection do
      get :api_search
      get :api_import
    end
  end

  resources :recipes do
    collection do
      get :api_search
      get :api_import
    end
  end

  get '/search', to: 'search#index'
  root "home#index"
end
