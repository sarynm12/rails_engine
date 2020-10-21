Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #get "/api/v1/items", to: 'search#show'
  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: 'merchants/find#show'
      get '/merchants/find_all', to: 'merchants/find#index'

      get '/items/find', to: 'items/find#show'
      get '/items/find_all', to: 'items/find#index'

      # post '/items', to: 'items#create'
      # patch '/items/:id', to: 'items#update'
      # delete '/items/:id', to: 'items#destroy'
      # get '/merchant', to: 'items/merchant#index'
      # post '/merchants', to: 'merchants#create'
      # patch '/merchants/:id', to: 'merchants#update'
      # delete '/merchants/:id', to: 'merchants#destroy'

      resources :items, only: [:index, :show, :create, :update, :destroy] do
        get '/merchant', to: 'items/merchant#index'
      end

      resources :merchants, only: [:index, :show, :create, :update, :destroy] do
        get '/items', to: 'merchants/items#index'
        #get '/find', to: 'merchants/find#show'
      end
    end
  end
end
