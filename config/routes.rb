Lolly01::Application.routes.draw do
  resources :users

  resources :urls

  root to: "urls#index"
end
