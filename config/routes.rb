Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :invoices do
        get 'find', to: 'finder#show'
        get 'find_all', to: 'finder#index'
        get 'random', to: 'random#show'
        get ':id/transactions', to: 'transactions#index'
        get ':id/invoice_items', to: 'invoice_items#index'
        get ':id/items', to: 'items#index'
        get ':id/customer', to: 'customers#show'
        get ':id/merchant', to: 'merchants#show'
      end
      resources :invoices, only: [:index, :show]

      namespace :items do
        get 'find', to: 'finder#show'
        get 'find_all', to: 'finder#index'
        get 'random', to: 'random#show'
      end
      resources :items, only: [:index, :show]

      namespace :invoice_items do
        get 'find', to: 'finder#show'
        get 'find_all', to: 'finder#index'
        get 'random', to: 'random#show'
        get ':id/invoice', to: 'invoices#show'
        get ':id/item', to: 'items#show'
      end
      resources :invoice_items, only: [:index, :show]
      namespace :merchants do
        get 'find_all', to: 'finder#index'
        get 'find', to: 'finder#show'
        get 'random', to: 'random#show'
        get 'most_items', to: 'items#index'
        get 'revenue', to: 'revenue#date'
        get 'most_revenue', to: 'revenue#index'
        get ':id/revenue', to: 'revenue#show'
      end
      resources :merchants, only: [:index, :show]
      namespace :transactions do
        get 'find_all', to: 'finder#index'
        get 'find', to: 'finder#show'
        get 'random', to: 'random#show'
      end
      resources :transactions, only: [:index, :show]
      namespace :customers do
        get 'find_all', to: 'finder#index'
        get 'find', to: 'finder#show'
        get 'random', to: 'random#show'
      end
      resources :customers, only: [:index, :show]
    end
  end
end
