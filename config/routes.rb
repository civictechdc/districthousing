DchousingApps::Application.routes.draw do
  resources :residences
  resources :incomes

  devise_for :users

  resources :applicants
  resources :household_members
  resources :landlords
  resources :housing_forms
  resources :salesforce, :only => [:index]

  get "home/index"
  get "/about", to: "home#about"
  get "/download", to: "main_form#download"
  get "/apply", to: "main_form#index"

  get "/pdf_guide", to: "pdf_guide#index"
  get "/dictionary", to: "dictionary#index"

  get 'onboarding', to: 'home#onboarding'

  root to: 'home#index'
end
