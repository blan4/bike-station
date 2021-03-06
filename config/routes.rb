Rails.application.routes.draw do
  get 'operators/:id/activate' => 'operators#activate', as: :activate_operator
  get 'operators/:id/deactivate' => 'operators#deactivate', as: :deactivate_operator
  get 'auth/:provider/callback' => 'session#create'
  delete 'auth/logout' => 'session#destroy'
  get 'login' => 'session#new'

  root 'stations#index'

  resources :stations do
    resources :rents do
      get 'open', on: :collection, to: 'rents#opening'
      get 'close', on: :collection, to: 'rents#closing'
      post 'open', on: :collection
      patch 'close', on: :member
    end
    get 'history', on: :member
  end

  namespace :api do
    namespace :v1 do
      post 'bikes' => 'bikes#register'
      get 'stations' => 'stations#index'
      get 'stations/map' => 'stations#map', as: :stations_map
      post 'bikes/:uuid/location' => 'bikes#location'
      get 'bikes/locations' => 'bikes#locations'
    end
  end
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
