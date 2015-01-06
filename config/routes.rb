DchousingApps::Application.routes.draw do
  get "/salesforce_applicants/sync", to: "salesforce_applicants#sync_all"
  get "/salesforce_applicants/:id/sync", to: "salesforce_applicants#sync"

  devise_for :users

  resources :applicants
  resources :criminal_histories
  resources :employments
  resources :household_members
  resources :housing_forms
  resources :incomes
  resources :landlords
  resources :people
  resources :residences
  resources :salesforce_applicants

  get '/download/:id', to: 'housing_forms#download', as: 'download_housing_form'
  get "home/index"
  get "/about", to: "home#about"
  get "/pdf_guide", to: "pdf_guide#index"
  get "/dictionary", to: "dictionary#index"

  root to: 'home#index'
end
