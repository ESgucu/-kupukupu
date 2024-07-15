Rails.application.routes.draw do
  get 'trips/new'
  get 'trips/create'
  # get 'home/index'
  devise_for :users

  # root to: "pages#home"
  root 'home#index'
  get '/home', to: 'home#home'
  resources :groups do
    resources :memberships
  end

  # resources :trips, only: [:new, :create]
  # root 'trips#new'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
