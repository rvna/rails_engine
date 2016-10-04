Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get 'find_all', to: 'merchants_finder#index'
        get 'find', to: 'merchants_finder#show'
      end
      resources :merchants, only: [:index, :show]
    end
  end
end
