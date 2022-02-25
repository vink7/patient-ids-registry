Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :patients
  resources :identifications
  resources :recs

  root 'patients#new'

  get '/ping' => 'ping#ping' # ping for AWS ELB Health Check

  match '*path' => 'catch_all#index', via: :all # default bad request
end
