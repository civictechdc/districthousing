DchousingApps::Application.routes.draw do
  devise_for :users

  resources :buildings
  resources :housing_forms
  resources :line_items
  resources :carts
  resources :housing_forms

  resources :residents do
    get :fill_all_forms, on: :member
  end

  get "home/index"
  match "/about", :to => "home#about"
  match "/download", :to => "carts#download"
  match "/picker", :to => "form_picker#index"

  # Bypass the login for now
  #root :to => 'home#index'
  root :to => 'form_picker#index'
end
