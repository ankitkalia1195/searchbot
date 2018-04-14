Rails.application.routes.draw do
  use_doorkeeper scope: 'api/v1/oauth'
  # devise_for :users
  resources :links, only: :index

  root 'links#index'

  namespace :api do
    namespace :v1 do

      resources :links, only: :index
    end
  end
end
