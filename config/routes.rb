Rails.application.routes.draw do
  devise_for :users
  root 'pages#index'
  get 'pages/index'
  get 'pages/filter_categories', to: 'pages#filter_categories', as: 'filter_categories'
  post 'appointments/create', to: 'appointments#create', as: 'create_appointment'
  patch 'appointments/create', to: 'appointments#update', as: 'update_appointment'
end
