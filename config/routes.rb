Rails.application.routes.draw do
  get 'dashboard/index'
  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check
  root to: "dashboard#index"

  # Resources for services
  resources :services
  resources :contacts, only: [:index]
  resources :about, only: [:index]

  resources :bookings do
    collection do
      get :unavailable_times
    end
  end

end
