Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :carts
  'carts#index'
  match "carts/:id/hide" => "carts#hide", :as => "hide_cart", via: [:post]
  match "carts/:id/unhide" => "carts#unhide", :as => "unhide_cart", via: [:post]
  
  resources :categories
  'categories#index'
  match "categories/:id/hide" => "categories#hide", :as => "hide_category", via: [:post]
  match "categories/:id/unhide" => "categories#unhide", :as => "unhide_category", via: [:post]

  resources :subcategories
  'subcategories#index'
  match "subcategories/:id/hide" => "subcategories#hide", :as => "hide_subcategory", via: [:post]
  match "subcategories/:id/unhide" => "subcategories#unhide", :as => "unhide_subcategory", via: [:post]

  resources :products
  'products#index'
  match "products/:id/hide" => "products#hide", :as => "hide_product", via: [:post]
  match "products/:id/unhide" => "products#unhide", :as => "unhide_product", via: [:post]
  
  resources :purchases
  'purchases#index'
  match "purchases/:id/hide" => "purchases#hide", :as => "hide_purchase", via: [:post]
  match "purchases/:id/unhide" => "purchases#unhide", :as => "unhide_purchase", via: [:post]

  resources :users
  'users#index'
  
  resources :roles
  'roles#index'

  resources :login
  'login#index'
  
  root 'application#index' #'carts#index'

  match "application/toggle_hidden" => "application#toggle_hidden", :as => "toggle_hidden", via: [:get]
  
  # match "application/user1" => "application#user1", :as => "user1", via: [:get]
  # match "application/user2" => "application#user2", :as => "user2", via: [:get]
  
  match "application/logout" => "login#clear_login", :as => "logout", via: [:get]
  
  resources :application
  'application#index'


end
