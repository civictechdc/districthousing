DchousingApps::Application.routes.draw do
  devise_for :users

  resources :buildings
  resources :housing_forms
  resources :line_items
  resources :carts
  resources :housing_forms

  get "home/index"
  match "/about", :to => "home#about"
  match "/download", :to => "form_picker#download"
  match "/picker", :to => "form_picker#index"

  root :to => 'home#index'
end
