# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, path: 'admin'
  devise_for :employees, path: 'employees'

  root 'kudos#index'

  resources :kudos
  resources :rewards, only: %i[index show]
  resources :orders, only: %i[create]

  namespace :admin do
    root to: 'pages#dashboard'
    resources :kudos
    resources :company_values
    resources :rewards
  end
end
