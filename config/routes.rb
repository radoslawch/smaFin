Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  match 'application/no_permissions' => 'application#no_permissions', via: [:get]
  resources :carts
  match 'carts/:id/hide' => 'carts#hide', :as => 'hide_cart', via: [:post]
  match 'carts/:id/unhide' => 'carts#unhide', :as => 'unhide_cart', via: [:post]

  resources :categories
  match 'categories/:id/hide' => 'categories#hide', :as => 'hide_category', via: [:post]
  match 'categories/:id/unhide' => 'categories#unhide', :as => 'unhide_category', via: [:post]

  resources :subcategories
  match 'subcategories/:id/hide' => 'subcategories#hide', :as => 'hide_subcategory', via: [:post]
  match 'subcategories/:id/unhide' => 'subcategories#unhide', :as => 'unhide_subcategory', via: [:post]

  resources :products
  match 'products/:id/hide' => 'products#hide', :as => 'hide_product', via: [:post]
  match 'products/:id/unhide' => 'products#unhide', :as => 'unhide_product', via: [:post]

  resources :purchases
  match 'purchases/:id/hide' => 'purchases#hide', :as => 'hide_purchase', via: [:post]
  match 'purchases/:id/unhide' => 'purchases#unhide', :as => 'unhide_purchase', via: [:post]

  resources :users

  resources :roles

  resources :login

  root 'application#index'

  match 'application/toggle_hidden' => 'application#toggle_hidden', :as => 'toggle_hidden', via: [:get]

  match 'logout' => 'login#clear_login', via: [:get]

  resources :application
  'application#index'
end
