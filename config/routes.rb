Rails.application.routes.draw do
  resources :search
  get 'search/index'
  root 'search#index' , only: [:index]
end
