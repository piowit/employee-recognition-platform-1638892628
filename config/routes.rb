# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, path: 'admin'
  devise_for :employees, path: 'employees'

  root 'kudos#index'

  resources :kudos
  resources :rewards, only: %i[index show]
  resources :orders, only: %i[index create]

  namespace :admin do
    root to: 'pages#dashboard'
    resources :kudos
    resources :company_values
    resources :rewards
    resources :deliveries, only: %i[update]
    resources :orders, only: %i[index]
    resources :employees, only: %i[index] do
      patch 'add_kudos_for_all'
    end
  end
end
