DchousingApps::Application.routes.draw do
  devise_for :users

  resources :applicant
  resources :household_member
  resources :landlord
  resources :housing_forms
  resources :salesforce, :only => [:index]

  get "home/index"
  get "/about", to: "home#about"
  post "/download", to: "main_form#download"
  get "/form", to: "main_form#index"

  get "/pdf_guide", to: "pdf_guide#index"
  get "/dictionary", to: "dictionary#index"

  root to: 'home#index'
end
