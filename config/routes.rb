Rails.application.routes.draw do

  root "movies#index"

  resource :session, only: [:new, :create, :destroy]
  get "signin" => "sessions#new"
  
  resources :movies do
    resources :reviews
  end

  resources :users
  get "signup" => "users#new"
end
