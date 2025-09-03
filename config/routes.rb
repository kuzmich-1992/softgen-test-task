Rails.application.routes.draw do
  devise_for :users
  root 'pages#index'
  get 'pages/index'
  get 'pages/filter_categories', to: 'pages#filter_categories', as: 'filter_categories'
  post 'pages/create_category', to: 'pages#create_category', as: 'create_category'
  post 'appointments/create', to: 'appointments#create', as: 'create_appointment'
  patch 'appointments/create', to: 'appointments#update', as: 'update_appointment'
  patch 'pages/assign_category', to: 'pages#assign_category', as: 'assign_category'
end
