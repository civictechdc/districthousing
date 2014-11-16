DchousingApps::Application.routes.draw do
  resources :employments

  resources :residences
  resources :incomes

  devise_for :users

  resources :applicants
  resources :household_members
  resources :landlords
  resources :housing_forms
  get '/download/:id', to: 'housing_forms#download', as: 'download_housing_form'

  resources :salesforce, :only => [:index]
  resources :people

  get "home/index"
  get "/about", to: "home#about"

  get "/pdf_guide", to: "pdf_guide#index"
  get "/dictionary", to: "dictionary#index"

  get 'onboarding', to: 'home#onboarding'

  root to: 'home#index'
end
