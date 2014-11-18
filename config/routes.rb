DchousingApps::Application.routes.draw do
  devise_for :users
  get "/about", to: "home#about"
  get "/dictionary", to: "dictionary#index"
  get "/pdf_guide", to: "pdf_guide#index"
  get "/home/index"
  get "/download/:id", to: "housing_forms#download", as: "download_housing_form"
  get "/onboarding", to: "home#onboarding"
  post "/dictionary", to: "dictionary#index"
  resources :applicants
  resources :criminal_histories
  resources :employments
  resources :household_members
  resources :housing_forms
  resources :incomes
  resources :landlords
  resources :people
  resources :residences
  resources :salesforce, :only => [:index]
  root to: 'home#index'
end
