DchousingApps::Application.routes.draw do
  get "/salesforce_applicants/sync", to: "salesforce_applicants#sync_all"
  get "/salesforce_applicants/:id/sync", to: "salesforce_applicants#sync"

  devise_for :users

  get '/applicants/:applicant_id/household_members/edit', to: 'household_members#front', as: 'edit_household_members'

  resources :applicants do
    resources :household_members
  end

  resources :criminal_histories
  resources :employments
  resources :housing_forms
  resources :incomes
  resources :landlords
  resources :residences
  resources :salesforce_applicants

  get '/download/:id', to: 'housing_forms#download', as: 'download_housing_form'
  get "home/index"
  get "/about", to: "home#about"
  get "/pdf_guide", to: "pdf_guide#index"
  get "/dictionary", to: "dictionary#index"

  get "/applicants/:id/identity/edit", to: "identity#edit", as: 'edit_identity'
  patch "/applicants/:id/identity", to: "identity#update", as: 'identity'

  root to: 'home#index'
end
