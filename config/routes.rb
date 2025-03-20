Rails.application.routes.draw do
  get 'dashboard/index'
  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check
  root to: "dashboard#index"

  # Resources for services
  resources :services

  # Resources for bookings
  resources :bookings
end
