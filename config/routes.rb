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

  # ActiveAdmin routes
  ActiveAdmin.routes(self)

  # Devise routes for regular users
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  # Cart and Orders routes
  resource :cart, only: [:show] do
    post 'add/:id', to: 'cart#add', as: 'add_to'
    delete 'remove/:id', to: 'cart#remove', as: 'remove_from'
  end

  resources :orders, only: [:new, :create, :show]
  resources :products, only: [:show]

  # Define the root path route ("/")
  root to: "home#index"
end
