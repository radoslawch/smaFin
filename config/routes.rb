Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :spendings
   'spendings#index'

  resources :categories
  'categories#index'

  resources :subcategories
  'subcategories#index'

  resources :products
  'products#index'

  resources :carts
  root 'carts#index'

  match "carts/:id/hide" => "carts#hide", :as => "hide_cart", via: [:post]

  match "application/toggle_hidden" => "application#toggle_hidden", :as => "toggle_hidden", via: [:get]


  resources :purchases
  'purchases#index'

 
end
