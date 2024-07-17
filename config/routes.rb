Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get '/home', to: 'home#home'
  resources :groups do
    resources :memberships
  end
  get "up" => "rails/health#show", as: :rails_health_check

end
