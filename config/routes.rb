Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "home#index"
  resources :warehouses, only: [:show, :new, :create, :edit, :update, :destroy] do
    resources :stock_product_destinations, only: [:create]
  end
  resources :suppliers, only: [:index, :show, :new, :create, :edit, :update]
  resources :product_models, only: [:index, :new, :create, :show, :edit, :update]
  resources :orders, only: [:new, :create, :show, :index, :edit, :update] do
    get 'search', on: :collection
    post 'delivered', on: :member
    post 'canceled', on: :member
    resources :order_items, only: [:new, :create]
  end

  namespace :api do
    namespace :v1 do
      resources :warehouses, only: [:show, :index, :create]
    end
  end
  
end
