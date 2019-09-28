Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "welcome#index"

get "/login", to: "sessions#new"
post "/login", to: "sessions#create"
delete "/logout", to: "sessions#destroy"

get "/register", to: "users#new"
post "/register", to: "users#create"

namespace :merchant do
  get "/", to: "dashboard#index", as: :user
  get "/orders/:id", to: "dashboard#show", as: :orders_show

  resources :orders, only: [:show]
  resources :items, as: :user
  resources :coupons
end

patch "/merchant/:order_id/:item_order_id/fulfill", to: "merchant/orders#fulfill"
patch "/merchant/items/:item_id/update_status", to: "merchant/items#update_status"
patch "/merchants/:id/update_status", to: "merchants#update_status"
patch "/merchant/coupons/:id/update_status", to: "merchant/coupons#update_status"

resources :merchants do
  resources :items, only: [:index]
end

resources :items, except: [:new, :create] do
  resources :reviews, except: [:show, :index]
end

patch "/orders/:id", to: "orders#cancel", as: :order_cancel

namespace :admin do
  get "/", to: "dashboard#index"
  patch "/orders/:order_id/update_status", to: "dashboard#update_status"

  resources :users, only: [:index, :show]
  resources :merchants, only: [:show]
end

get "/profile", to: "users#show"
get "/profile/edit", to: "users#edit"
patch "/profile", to: "users#update"
get "/profile/edit_password", to: "users#edit_password"
patch "/profile/update_password", to: "users#update_password"

scope :profile, as: :profile do
  resources :orders, except: [:index, :destroy, :show]

  get "/orders", to: "users#show_orders"
  get "/orders/:id", to: "users#show_order"
  post "/orders/coupon", to: "orders#update_total"
end

scope :profile, as: :profile do
  resources :addresses, except: [:index]
end

scope :cart, as: :cart do
  get "/", to: "cart#show"
  post "/:item_id", to: "cart#add_item"
  patch "/:item_id/:increment_decrement", to: "cart#increment_decrement"
  delete "/", to: "cart#empty"
  delete "/:item_id", to: "cart#remove_item"
end
end
