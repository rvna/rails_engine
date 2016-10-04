Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :invoices do
        get 'find', to: 'invoices_finder#show'
        get 'find_all', to: 'invoices_finder#index'
        get 'random', to: 'invoice_random#show'
      end
      resources :invoices, only: [:index, :show]

      namespace :items do
        get 'find', to: 'items_finder#show'
        get 'find_all', to: 'items_finder#index'
        get 'random', to: 'item_random#show'
      end
      resources :items, only: [:index, :show]

      namespace :invoice_items do
        get 'find', to: 'invoice_items_finder#show'
        get 'find_all', to: 'invoice_items_finder#index'
        get 'random', to: 'invoice_item_random#show'
      end
      resources :invoice_items, only: [:index, :show]
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
