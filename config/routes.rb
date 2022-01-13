# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, path: 'admin'
  devise_for :employees, path: 'employees'

  root 'kudos#index'

  resources :kudos

  namespace :admin do
    root to: 'pages#dashboard'
    resources :kudos
    resources :company_value
  end
end
