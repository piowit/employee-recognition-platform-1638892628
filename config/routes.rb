# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, path: 'admin'
  devise_for :employees, path: 'employees'

  root 'kudos#index'

  resources :kudos
  resources :rewards, only: %i[index show]
  resources :orders, only: %i[index new create]

  namespace :admin do
    root to: 'pages#dashboard'
    resources :kudos
    resources :company_values
    resources :rewards do
      collection { post :import }
      collection { get :export }
    end
    resources :categories
    resources :deliveries, only: %i[update]
    resources :orders, only: %i[index] do
      collection { get :export }
    end
    resources :employees do
      patch 'add_kudos_for_all'
    end
  end
end
