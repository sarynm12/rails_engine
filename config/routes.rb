Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #get "/api/v1/items", to: 'search#show'
  namespace :api do
    namespace :v1 do
      post '/items', to: 'items#create'
      # namespace :merchants do
      #   get '/find', to: 'search#show'
      # end

      namespace :items do
        get '/', to: 'search#index'
        get '/:id', to: 'search#show'
      end
    end
  end
end
