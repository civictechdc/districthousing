DchousingApps::Application.routes.draw do
  get "/salesforce_applicants/sync", to: "salesforce_applicants#sync_all"
  get "/salesforce_applicants/:id/sync", to: "salesforce_applicants#sync"

  devise_for :users

  get "/applicants/:id/identity/edit", to: "identity#edit", as: 'edit_identity'
  patch "/applicants/:id/identity", to: "identity#update", as: 'identity'

  get '/applicants/:applicant_id/household_members/edit', to: 'household_members#front', as: 'edit_household_members'
  get '/applicants/:applicant_id/residences/edit', to: 'residences#front', as: 'edit_residences'
  get '/applicants/:applicant_id/incomes/edit', to: 'incomes#front', as: 'edit_incomes'
  get '/applicants/:applicant_id/employments/edit', to: 'employments#front', as: 'edit_employments'
  get '/applicants/:applicant_id/criminal_histories/edit', to: 'criminal_histories#front', as: 'edit_criminal_histories'

  resources :applicants do
    resources :household_members
    resources :residences
    resources :employments
    resources :incomes
    resources :criminal_histories
  end

  resources :housing_forms
  resources :landlords
  resources :salesforce_applicants

  get '/download/:id', to: 'housing_forms#download', as: 'download_housing_form'
  get "home/index"
  get "/about", to: "home#about"
  get "/pdf_guide", to: "pdf_guide#index"
  get "/dictionary", to: "dictionary#index"

  root to: 'home#index'
end
