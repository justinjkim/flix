Rails.application.routes.draw do

  root "movies#index"

  resource :session, only: [:new, :create, :destroy]
  get "signin" => "sessions#new"

  resources :movies do
    resources :reviews
    resources :favorites, only: [:create, :destroy] # nest favorites under movies so that specific movie is always specified
  end

  resources :users
  get "signup" => "users#new"
end
