DchousingApps::Application.routes.draw do
  get "/salesforce_applicants/sync", to: "salesforce_applicants#sync_all"
  get "/salesforce_applicants/:id/sync", to: "salesforce_applicants#sync"

  devise_for :users

  get "/applicants/:applicant_id/identity/edit", to: "identity#edit", as: 'edit_identity'
  patch "/applicants/:applicant_id/identity", to: "identity#update", as: 'identity'

  get '/applicants/:applicant_id/identity/front', to: 'identity#front', as: 'identity_front'
  get '/applicants/:applicant_id/household_members/front', to: 'household_members#front', as: 'household_members_front'
  get '/applicants/:applicant_id/residences/front', to: 'residences#front', as: 'residences_front'
  get '/applicants/:applicant_id/incomes/front', to: 'incomes#front', as: 'incomes_front'
  get '/applicants/:applicant_id/employments/front', to: 'employments#front', as: 'employments_front'
  get '/applicants/:applicant_id/criminal_histories/front', to: 'criminal_histories#front', as: 'criminal_histories_front'
  get '/applicants/:applicant_id/contacts/front', to: 'contacts#front', as: 'contacts_front'

  get '/applicants/:applicant_id/identity/back', to: 'identity#back', as: 'identity_back'
  get '/applicants/:applicant_id/household_members/back', to: 'household_members#back', as: 'household_members_back'
  get '/applicants/:applicant_id/residences/back', to: 'residences#back', as: 'residences_back'
  get '/applicants/:applicant_id/incomes/back', to: 'incomes#back', as: 'incomes_back'
  get '/applicants/:applicant_id/employments/back', to: 'employments#back', as: 'employments_back'
  get '/applicants/:applicant_id/criminal_histories/back', to: 'criminal_histories#back', as: 'criminal_histories_back'
  get '/applicants/:applicant_id/contacts/back', to: 'contacts#back', as: 'contacts_back'

  resources :applicants do
    resources :household_members
    resources :residences
    resources :employments
    resources :incomes
    resources :criminal_histories
    resources :contacts
  end

  resources :housing_forms
  resources :landlords
  resources :salesforce_applicants

  get '/download/:id', to: 'housing_forms#download', as: 'download_housing_form'
  get '/download/blank/:id', to: 'housing_forms#download_blank', as: 'download_blank_housing_form'
  get "home/index"
  get "/pdf_guide", to: "pdf_guide#index"
  get "/dictionary", to: "dictionary#index"
  get "/dictionary/test.json", to: "dictionary#test"

  root to: 'home#index'
end
