Rails.application.routes.draw do
  get 'trips/index'
  resources :routes, only: [:index]
  resources :trips, only: [:index]
end
