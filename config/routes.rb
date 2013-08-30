Lolly01::Application.routes.draw do
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  %w[about dictionary].each do |page|
    get page, controller: 'static_pages', action: page
  end

  resources :users, except: [:edit, :update]
  resources :sessions, only: [:new, :create, :destroy]

  resources :urls, except: [:edit, :update] do
    member do
      get :delete
      delete :delete, action: :destroy
    end
  end

  get '/:converted_url', to: 'urls#show', constraints: { converted_url: /[^_]*_[^_]*_[^_]*/ }

  match '(errors)/:status', to: 'errors#show',
    constraints: { status: /\d{3}/ },
    defaults: { status: '500' },
    via: :all

  root to: "urls#index"
end