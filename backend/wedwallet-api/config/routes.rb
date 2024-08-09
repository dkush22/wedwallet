Rails.application.routes.draw do

  # User routes
  resources :users, only: [:create, :show, :index]

  get 'current_user', to: 'users#show_current_user'

  # Authentication routes
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # Wedding routes
  resources :weddings, only: [:new, :create, :show] do
    # Nested routes for managing cards and gifts within a wedding
    resources :cards, only: [:new, :create]
    resources :gifts, only: [:new, :create]
  end
end
