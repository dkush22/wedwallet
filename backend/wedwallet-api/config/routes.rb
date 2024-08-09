Rails.application.routes.draw do
  resources :users, only: [:create, :show, :index]
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :weddings, only: [:new, :create, :show]
end
