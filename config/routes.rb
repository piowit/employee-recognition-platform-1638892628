# frozen_string_literal: true

Rails.application.routes.draw do
  resources :kudos
  devise_for :admin_users, path: 'admin'
  devise_for :employees, path: 'employees'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'kudos#index'

  namespace :admin do
    root to: 'pages#dashboard'
  end
end
