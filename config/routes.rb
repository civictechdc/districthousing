DchousingApps::Application.routes.draw do
  devise_for :users

  resources :residents

  get "home/index"

  root :to => 'home#index'
end