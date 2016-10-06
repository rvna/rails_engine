Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :invoices do
        get 'find', to: 'finder#show'
        get 'find_all', to: 'finder#index'
        get 'random', to: 'random#show'
      end
      resources :invoices, only: [:index, :show] do
        scope module: 'invoices' do
          get 'transactions', to: 'transactions#index'
          get 'invoice_items', to: 'invoice_items#index'
          get 'items', to: 'items#index'
          get 'customer', to: 'customers#show'
          get 'merchant', to: 'merchants#show'
        end
      end

      namespace :items do
        get 'find', to: 'finder#show'
        get 'find_all', to: 'finder#index'
        get 'random', to: 'random#show'
      end
      resources :items, only: [:index, :show] do
        scope module: 'items' do
          get 'invoice_items', to: 'invoice_items#index'
          get 'merchant', to: 'merchant#show'
        end
      end

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
        get 'most_items', to: 'top_items#index'
        get 'revenue', to: 'revenue#date'
        get 'most_revenue', to: 'revenue#index'
        get ':id/revenue', to: 'revenue#show'
      end
      resources :merchants, only: [:index, :show] do
        scope module: 'merchants' do
          get 'items', to: 'items#index'
          get 'invoices', to: 'invoices#index'
        end
      end

      namespace :transactions do
        get 'find_all', to: 'finder#index'
        get 'find', to: 'finder#show'
        get 'random', to: 'random#show'
      end
      resources :transactions, only: [:index, :show] do
        scope module: 'transactions' do
          get 'invoice', to: 'invoice#show'
        end
      end

      namespace :customers do
        get 'find_all', to: 'finder#index'
        get 'find', to: 'finder#show'
        get 'random', to: 'random#show'
      end
      resources :customers, only: [:index, :show] do
        scope module: 'customers' do
          get 'invoices', to: 'invoices#index'
          get 'transactions', to: 'transactions#index'
        end
      end
    end
  end
end
