Rails.application.routes.draw do
  devise_for :users
  root 'pages#index'
  get 'pages/index'
  post 'appointments/create', to: 'appointments#create', as: 'create_appointment'
  patch 'appointments/create', to: 'appointments#update', as: 'update_appointment'
end
