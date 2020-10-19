Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #get "/api/v1/items", to: 'search#show'
  namespace :api do
    namespace :v1 do
      post '/items', to: 'items#create'
      patch '/items/:id', to: 'items#update'
      delete '/items/:id', to: 'items#destroy'

      namespace :merchants do
        get '/', to: 'search#index'
        get '/:id', to: 'search#show'
      end

      namespace :items do
        get '/', to: 'search#index'
        get '/:id', to: 'search#show'
      end
    end
  end
end
