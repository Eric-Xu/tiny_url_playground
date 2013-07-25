Lolly01::Application.routes.draw do
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :urls
  resources :users, only: [:index, :new, :create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]

  root to: "urls#index"
end
