Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  get  '/profile',      to: 'profile#show',   as: :profile
  get  '/profile/edit', to: 'profile#edit',   as: :edit_profile
  patch '/profile',     to: 'profile#update'
  resources :watch_lists, only: [:show, :create, :update, :destroy] do
    collection do
      patch :reorder
    end
  end

  devise_for :users

  resources :movies do
    collection do
      get  :api_search
      post :api_import
    end
    member do
      post   :add_to_list
      delete :remove_from_list
      patch  :update_status
    end
  end

  resources :books do
    collection do
      get  :api_search
      post :api_import
    end
    member do
      post   :add_to_list
      delete :remove_from_list
      patch  :update_status
    end
  end

  resources :recipes do
    collection do
      get  :api_search
      post :api_import
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
