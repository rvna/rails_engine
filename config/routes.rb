Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get 'find_all', to: 'merchants_finder#index'
        get 'find', to: 'merchants_finder#show'
        get 'random', to: 'merchants_random#show'
      end
      resources :merchants, only: [:index, :show]
      namespace :transactions do
        get 'find_all', to: 'transactions_finder#index'
        get 'find', to: 'transactions_finder#show'
        get 'random', to: 'transactions_random#show'
      end
      resources :transactions, only: [:index, :show]
      namespace :customers do
        get 'find_all', to: 'customers_finder#index'
        get 'find', to: 'customers_finder#show'
        get 'random', to: 'customers_random#show'
      end
      resources :customers, only: [:index, :show]
    end
  end
end
