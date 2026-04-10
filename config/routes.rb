Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users

  resources :movies, only: [:index, :show] do
    collection do
      get  :api_search
      get  :api_import
    end
    member do
      post   :add_to_list
      delete :remove_from_list
      patch  :update_status
    end
  end

  resources :books, only: [:index, :show] do
    collection do
      get  :api_search
      get  :api_import
    end
    member do
      post   :add_to_list
      delete :remove_from_list
      patch  :update_status
    end
  end

  resources :recipes, only: [:index, :show] do
    collection do
      get  :api_search
      get  :api_import
    end
    member do
      post   :add_to_list
      delete :remove_from_list
      patch  :update_status
    end
  end

  get '/search', to: 'search#index'
  root "home#index"
end
