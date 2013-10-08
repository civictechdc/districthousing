DchousingApps::Application.routes.draw do
  resources :buildings
  resources :housing_forms

  devise_for :users

  resources :residents

  get "home/index"
  match "/about", :to => "home#about"

  root :to => 'home#index'
end
