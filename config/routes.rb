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

  root :to => 'housing_forms#index'
end
