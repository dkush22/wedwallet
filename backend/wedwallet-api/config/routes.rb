Rails.application.routes.draw do

  # User routes
  resources :users, only: [:create, :show, :index]

  get 'current_user', to: 'users#show_current_user'
  get 'my_wedding', to: 'weddings#my_wedding'
  get 'weddings/upcoming', to: 'weddings#upcoming'
  get 'weddings/past', to: 'weddings#past'
  get 'gifts/download_csv', to: 'gifts#download_csv', as: 'download_gifts_csv'

  # Authentication routes
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # Wedding routes
  resources :weddings, only: [:new, :create, :show] do
    # Nested routes for managing cards and gifts within a wedding
    resources :cards, only: [:new, :create]
    resources :gifts, only: [:new, :create]
    resources :couples, only: [:index, :show, :create, :update, :destroy]
  end
end
