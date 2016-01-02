Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users
  #api
  namespace :api do
    namespace :v1 do
      resources :users, only: [:show]
      resources :sessions, only: [:create]
    end
  end
end
