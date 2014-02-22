CompanyPortal::Application.routes.draw do

  get "customer_overview/index"
  get "archive/index"

  resources :payment_notifications do
    collection do
      post 'ipn_notification'
    end
  end

  resources :invoices do
    collection do
      get 'convert'
    end
    member do
      get 'payed'
    end
  end

  resources :installations do    
    collection do
      get 'open'
      get 'unassumed'
      get 'assumed'
      get 'convert'
    end
    member do
      get 'assume'
      get 'release'
    end
  end

  resources :installations do
    collection do
      get 'open'
      get 'unassumed'
      get 'assumed'
      get 'convert'
    end
    member do
      get 'assume'
      get 'release'
    end
  end
  
  ActiveAdmin.routes(self)

  resources :orders do
    collection do
      get 'delayed'
      get 'convert'
    end
  end

  resources :line_items do
    collection do
      patch 'increment'
      post 'decrement'
    end
    member do
      patch 'increment'
      post 'decrement'
    end
  end
  resources :carts

  resources :assignments do
    collection do
      get 'open'
      get 'unassumed'
      get 'assumed'
      get 'convert'
    end
    member do
      get 'assume'
      get 'release'
    end
  end
 

get 'reporting', controller: "reporting", action: "index"


get "reporting/shop", controller: "reporting", action:"shop"
get  "reporting/user", controller: "reporting", action:"user"
post "reporting/user", controller: "reporting", action:"user"
get  "reporting/bugreport", controller: "reporting", action:"bugreport"
post "reporting/bugreport", controller: "reporting", action:"bugreport"
get  "reporting/businessprocess", controller: "reporting", action:"businessprocess"
post "reporting/businessprocess", controller: "reporting", action:"businessprocess"

  resources :positions do
    member do
      post 'updateDeliverydate'
      get 'arrive'
    end
  end

  resources :offers do
    collection do
      get 'open'
      get 'unassumed'
      get 'assumed'
      get 'pending'
      get 'convert'
    end
    member do
      get 'assume'
      get 'release'
      get 'publish'
    end    
  end

  resources :requests do
    collection do
      get 'open'
      get 'unassumed'
      get 'assumed'
    end
    member do
      get 'assume'
      get 'release'
    end
  end


  get "welcome/index"
  resources :notes

  get "store/index"
  resources :articles

  resources :suppliers

  devise_for :users
  resources :bugreports do
    collection do
      get "open"
      get "unassumed"
      get "assumed"
      get "closed"
    end
    member do
      get "assume"
      get "release"
      get "close"
    end

  end

  root 'store#index', as: 'store'
  root 'welcome#index'
  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
