Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_scope :user do
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_omniauth_user_session
  end  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root to: "books#index"

  resources :users do
    post 'change_billing_address', :to => 'users#change_billing_address', :as => :change_billing_address, on: :collection    
    post 'change_shipping_address', :to => 'users#change_shipping_address', :as => :change_shipping_address, on: :collection 
    post 'change_email', :to => 'users#change_email', :as => :change_email, on: :collection 
    post 'change_password', :to => 'users#change_password', :as => :change_password, on: :collection    
  end
  resources :books do
    get 'index_shop', on: :collection
  end

  resources :orders do
    get 'cart', on: :collection
    get 'checkout', on: :collection
  end
  
  post "ratings" => 'ratings#create', as: :create_rating

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
