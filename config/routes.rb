Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get '/most_revenue', to: 'most_revenue#index'
        get '/most_items', to: 'most_items#index'
        get '/:id/favorite_customer', to: "favorites#show"
      end

      namespace :transactions do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end

      namespace :items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get '/:id/best_day', to: 'items_best_day#show'
      end

      namespace :invoices do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end

      namespace :invoice_items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end

      namespace :customers do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get '/:id/favorite_merchant', to: 'favorite_merchant#show'
      end

      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index]
        resources :invoices, only: [:index]
      end

      resources :items, only: [:index, :show] do
        resources :invoice_items, only: [:index]
        get '/merchant', to: 'merchants#show'
      end

      resources :invoices, only: [:index, :show] do
        get '/merchant', to: "merchants#show"
        get '/customer', to: "customers#show"
        resources :invoice_items, only: [:index]
        resources :transactions, only: [:index]
        resources :items, only: [:index]
      end

      resources :invoice_items, only: [:index, :show] do
        get '/invoice', to: "invoices#show"
        get '/item', to: "items#show"
      end

      resources :transactions, only: [:index, :show] do
        get '/invoice', to: "invoices#show"
      end

      resources :customers, only: [:index, :show] do
        resources :invoices, only: [:index]
        resources :transactions, only: [:index]
      end
    end
  end
end
