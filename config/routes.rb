Rails.application.routes.draw do
  # Define Devise routes for admin users with custom paths
  devise_for :admin_users, path: 'admin', controllers: {
    sessions: 'admin_users/sessions',
    registrations: 'admin_users/registrations',
    passwords: 'admin_users/passwords'
  }, path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    password: 'secret',
    confirmation: 'verification',
    unlock: 'unblock',
    registration: 'register',
    sign_up: 'cmon_let_me_in'
  }
  devise_scope :admin_user do
    get 'admin/logout', to: 'admin_users/sessions#destroy', as: :custom_destroy_admin_user_session
  end

  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
  end

  # ActiveAdmin routes
  ActiveAdmin.routes(self)

  # Devise routes for regular users with custom paths
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }, path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    password: 'secret',
    confirmation: 'verification',
    unlock: 'unblock',
    registration: 'register',
    sign_up: 'cmon_let_me_in'
  }

  devise_scope :user do
    get 'users/logout', to: 'users/sessions#destroy', as: :custom_destroy_user_session
  end

  # Cart and Orders routes
  resource :cart, only: [:show], controller: 'cart' do
    post 'add/:id', to: 'cart#add', as: 'add_to'
    patch 'update/:id', to: 'cart#update', as: 'update'
    delete 'remove/:id', to: 'cart#remove', as: 'remove_from'
  end

  resources :orders, only: [:index, :new, :create, :show] do
    post 'recalculate_total', on: :collection
  end


  resources :products, only: [:index, :show]
  resources :pages, only: [:show]
  resources :categories, only: [:show]

  # Ensure these routes use the correct page slugs or ids
  get '/contact', to: 'pages#show', defaults: { id: Page.find_by(title: 'Contact')&.id || -1 }
  get '/about', to: 'pages#show', defaults: { id: Page.find_by(title: 'About')&.id || -1 }

  require 'active_storage/engine'
  ActiveStorage::Engine.routes.draw do
    get  "/blobs/redirect/:signed_id/*filename" => "active_storage/blobs#show", as: :rails_storage_redirect
    get  "/blobs/:signed_id/*filename" => "active_storage/blobs#show", as: :rails_storage_proxy
    get  "/representations/redirect/:signed_blob_id/:variation_key/*filename" => "active_storage/representations#show", as: :rails_blob_representation_redirect
    get  "/representations/:signed_blob_id/:variation_key/*filename" => "active_storage/representations#show", as: :rails_blob_representation_proxy
    get  "/disk/:encoded_key/*filename" => "active_storage/disk#show", as: :rails_disk_service
    put  "/disk/:encoded_token" => "active_storage/disk#update", as: :update_rails_disk_service
    post "/direct_uploads" => "active_storage/direct_uploads#create", as: :rails_direct_uploads
  end
  # Define the root path route ("/")
  root to: "home#index"
  get 'search', to: 'home#search'


end
