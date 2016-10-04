Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :invoices do
        get 'find', to: 'invoices_finder#show'
        get 'find_all', to: 'invoices_finder#index'
      end
      resources :invoices, only: [:index, :show]
    end
  end
end
