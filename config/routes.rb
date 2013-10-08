DchousingApps::Application.routes.draw do
  resources :buildings
  resources :housing_forms

  devise_for :users

  resources :housing_forms

  resources :residents do
    get :fill_all_forms, on: :member
  end

  get "home/index"
  match "/about", :to => "home#about"

  root :to => 'home#index'
end
