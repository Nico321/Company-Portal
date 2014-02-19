CompanyPortal::Application.routes.draw do

  resources :payment_notifications do
    collection do
      post 'ipn_notification'
    end
  end

  resources :invoices do
    member do
      get 'convert'
      get 'payed'
    end
  end

  resources :installations do    
    collection do
      get 'open'
      get 'unassumed'
      get 'assumed'
    end
    member do
      get 'convert'
      get 'assume'
      get 'release'
    end
  end

  resources :installations do
    collection do
      get 'open'
      get 'unassumed'
      get 'assumed'
    end
    member do
      get 'convert'
      get 'assume'
      get 'release'
    end
  end
  
  ActiveAdmin.routes(self)

  resources :orders do
    collection do
      get 'delayed'
    end
    member do
      get 'convert'
    end
  end

  resources :assignments do
    collection do
      get 'open'
      get 'unassumed'
      get 'assumed'
    end
    member do
      get 'convert'
      get 'assume'
      get 'release'
    end
  end

get 'reporting', controller: "reporting", action: "index"
get "reporting/bugreport", controller: "reporting", action:"bugreport"
get "reporting/process", controller: "reporting", action:"process"
get "reporting/shop", controller: "reporting", action:"shop"
get "reporting/user", controller: "reporting", action:"user"
post "reporting/bugreport", controller: "reporting", action:"bugreport"

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
    end
    member do
      get 'convert'
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
