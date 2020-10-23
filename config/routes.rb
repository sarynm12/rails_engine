Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #get "/api/v1/items", to: 'search#show'
  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: 'merchants/find#show'
      get '/merchants/find_all', to: 'merchants/find#index'
      get '/merchants/most_revenue', to: 'merchants/revenue#index'
      get '/merchants/most_items', to: 'merchants/most_items#index'
  
      get '/items/find', to: 'items/find#show'
      get '/items/find_all', to: 'items/find#index'

      resources :items, only: [:index, :show, :create, :update, :destroy] do
        get '/merchant', to: 'items/merchant#index'
      end

      resources :merchants, only: [:index, :show, :create, :update, :destroy] do
        get '/items', to: 'merchants/items#index'
      end
    end
  end
end
