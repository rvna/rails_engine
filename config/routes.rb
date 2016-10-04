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
      end
      resources :items, only: [:index, :show]
    end
  end
end
