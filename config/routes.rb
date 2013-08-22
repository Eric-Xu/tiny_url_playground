Lolly01::Application.routes.draw do
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  %w[about dictionary].each do |page|
    get page, controller: 'static_pages', action: page
  end

  resources :urls, except: [:edit, :update] do
    member do
      get :delete
      delete :delete, action: :destroy
    end
  end

  resources :users, only: [:index, :new, :create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]

  get '/:converted_url', to: 'urls#show'

  root to: "urls#index"
end
